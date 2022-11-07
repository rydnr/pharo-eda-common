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
			| localeName localeID locale |
			localeName := self removeSuffix: '.json' from: file basename.
			localeID := LocaleID isoString: localeName.
			locale := self translations
				          at: localeID
				          ifAbsentPut: [ Dictionary new ].
			locale addAll: (NeoJSONReader on: file readStream) next ] ]
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
