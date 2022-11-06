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
		'locations',
		'locales'
	],
	#classVars : [
		'DefaultLocations'
	],
	#category : #'EDAC-Localization'
}

{ #category : #defaults }
EDACTranslationProvider class >> addDefaultLocation: aFolder [

	self defaultLocations add: aFolder
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
	"self readTranslationsFromLocations"
]

{ #category : #accessing }
EDACTranslationProvider >> locales [

	^ locales ifNil: [ self locales: Dictionary new. locales ]
]

{ #category : #accessing }
EDACTranslationProvider >> locales: aDictionary [

	locales := aDictionary
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
			| localeName locale |
			localeName := self removeSuffix: '.json' from: file basename.
			locale := self locales
				          at: localeName
				          ifAbsentPut: [ Dictionary new ].
			locale addAll: (NeoJSONReader on: file readStream) next ] ]
]

{ #category : #translate }
EDACTranslationProvider >> translate: aString [

	^ aString
]

{ #category : #translate }
EDACTranslationProvider >> translate: aString to: aLocale [

	^ aString
]

{ #category : #accessing }
EDACTranslationProvider >> translations [

	^ translations
]

{ #category : #accessing }
EDACTranslationProvider >> translations: anObject [

	translations := anObject
]
