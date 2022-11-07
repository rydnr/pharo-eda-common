"
_Class_

I represent something than can provide text translations.

_Responsibilities_

I read json files and use their contents as translations.
"
Class {
	#name : #EDACTranslationProvider,
	#superclass : #Object,
	#traits : 'EDACLanguageHelper',
	#classTraits : 'EDACLanguageHelper classTrait',
	#instVars : [
		'translations',
		'locations'
	],
	#classVars : [
		'DefaultLocations'
	],
	#category : #'EDAC-Localization'
}

{ #category : #defaults }
EDACTranslationProvider class >> addDefaultLocation: aFolder [

	| locations |
	locations := self defaultLocations.
	(locations includes: aFolder) ifFalse: [ locations add: aFolder ]
]

{ #category : #defaults }
EDACTranslationProvider class >> defaultLocations [

	^ DefaultLocations ifNil: [ 
		  DefaultLocations := OrderedCollection
			                      with:
			                      FileSystem workingDirectory / 'resources'
			                      / 'l10n'.
			                      
		  DefaultLocations ]
]

{ #category : #initialization }
EDACTranslationProvider >> initialize [

	super initialize.
	translations := Dictionary new.
	locations := OrderedCollection withAll: self class defaultLocations.
	self readTranslationsFromLocations
]

{ #category : #accessing }
EDACTranslationProvider >> locations [

	^ locations select: [ :each | each exists ]
]

{ #category : #accessing }
EDACTranslationProvider >> locations: anObject [

	locations := anObject
]

{ #category : #initialization }
EDACTranslationProvider >> readTranslationsFromLocations [

	self locations do: [ :each | 
		each entries do: [ :file | 
			| localeName localeID locale block mappings |
			localeName := self removeSuffix: '.json' from: file basename.
			localeID := LocaleID isoString: localeName.
			locale := self translations
				          at: localeID
				          ifAbsentPut: [ Dictionary new ].
			block := [ :parent :entry :innerTranslations :innerBlock | 
			         entry keysAndValuesDo: [ :k :v | 
				         | key |
				         key := ('' join: { 
						                 parent.
						                 '.'.
						                 k }) asSymbol.
				         v isDictionary ifTrue: [ 
					         innerBlock
						         value: key
						         value: v
						         value: innerTranslations
						         value: innerBlock ] ifFalse: [ innerTranslations at: key put: v ] ] ].
			mappings := Dictionary new.
			(NeoJSONReader on: file readStream) next keysAndValuesDo: [ :k :v | 
				block
					value: k
					value: v
					value: mappings
					value: block ].
			locale addAll: mappings ] ]
]

{ #category : #translate }
EDACTranslationProvider >> translate: aString [

	^ self translate: aString toLocale: LocaleID current
]

{ #category : #translate }
EDACTranslationProvider >> translate: aString toLocale: aLocaleID [

	| translationsInLocale |
	translationsInLocale := translations at: aLocaleID ifAbsent: [ 
		                        aLocaleID isoCountry
			                        ifNil: [ Dictionary new ]
			                        ifNotNil: [ :l | 
			                        translations
				                        at: aLocaleID parent
				                        ifAbsent: [ Dictionary new ] ] ].
	^ translationsInLocale at: aString ifAbsent: [ aString ]
]

{ #category : #accessing }
EDACTranslationProvider >> translations [

	^ translations ifNil: [ self translations: Dictionary new. translations ]
]

{ #category : #accessing }
EDACTranslationProvider >> translations: aDictionary [

	translations := aDictionary
]
