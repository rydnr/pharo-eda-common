Class {
	#name : #EDACTranslationProvider,
	#superclass : #Object,
	#instVars : [
		'translations',
		'locations'
	],
	#classVars : [
		'DefaultLocations',
		'TranslationsFolder'
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
			                      / 'l10n'
			                      with: self translationsFolder ]
]

{ #category : #accessing }
EDACTranslationProvider class >> translationsFolder [

	^ TranslationsFolder
]

{ #category : #accessing }
EDACTranslationProvider class >> translationsFolder: aFolder [

	TranslationsFolder := aFolder
]

{ #category : #initialization }
EDACTranslationProvider >> initialize [

	super initialize.
	translations := Dictionary new.
	locations := OrderedCollection withAll: self class defaultLocations
]

{ #category : #accessing }
EDACTranslationProvider >> locations [

	^ locations
]

{ #category : #accessing }
EDACTranslationProvider >> locations: anObject [

	locations := anObject
]

{ #category : #accessing }
EDACTranslationProvider >> translations [

	^ translations
]

{ #category : #accessing }
EDACTranslationProvider >> translations: anObject [

	translations := anObject
]
