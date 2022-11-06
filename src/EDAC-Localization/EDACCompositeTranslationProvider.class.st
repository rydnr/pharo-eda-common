Class {
	#name : #EDACCompositeTranslationProvider,
	#superclass : #Object,
	#instVars : [
		'providers'
	],
	#category : #'EDAC-Localization'
}

{ #category : #'instance creation' }
EDACCompositeTranslationProvider class >> with: aProvider [

	^ self new
		  addProvider: aProvider;
		  yourself
]

{ #category : #'instance creation' }
EDACCompositeTranslationProvider class >> with: aProvider with: anotherProvider [

	^ (self with: aProvider) addProvider: anotherProvider;
		  yourself
]

{ #category : #'instance creation' }
EDACCompositeTranslationProvider class >> wrapCurrent [

	^ self with: EDACTranslationProvider new with: NaturalLanguageTranslator current
]

{ #category : #accessing }
EDACCompositeTranslationProvider >> addProvider: aProvider [

	aProvider ifNotNil: [ :p | self providers add: p ]
]

{ #category : #accessing }
EDACCompositeTranslationProvider >> providers [

	^ providers ifNil: [ self providers: OrderedCollection new. providers ]
]

{ #category : #accessing }
EDACCompositeTranslationProvider >> providers: anObject [

	providers := anObject
]

{ #category : #accessing }
EDACCompositeTranslationProvider >> translate: aString [

	^ (self providers
		   detect: [ :each | (each translate: aString) isNotNil ]
		   ifNone: [ EDACTranslationProvider new ]) translate: aString
]

{ #category : #accessing }
EDACCompositeTranslationProvider >> translate: aString to: aLocale [

	^ (self providers
		   detect: [ :each | (each translate: aString to: aLocale) isNotNil ]
		   ifNone: [ EDACTranslationProvider new ]) translate: aString to: aLocale
]
