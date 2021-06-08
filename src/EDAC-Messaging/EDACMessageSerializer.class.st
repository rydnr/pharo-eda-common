Class {
	#name : #EDACMessageSerializer,
	#superclass : #Object,
	#traits : 'EDACPrintOnHelper',
	#classTraits : 'EDACPrintOnHelper classTrait',
	#category : 'EDAC-Messaging'
}

{ #category : #parsing }
EDACMessageSerializer class >> eventClassPrefix: aClass [
	^ (aClass asString regex: '^([A-Z]+)' matchesCollect: [ :each | each asString ]) first allButLast
]

{ #category : #parsing }
EDACMessageSerializer class >> nameForMessageClass: aMessageClass [
	^ ((self nameWithoutPrefixForMessageClass: aMessageClass)
		copyWithRegex: '([A-Z]+)([a-z]+)'
		matchesTranslatedUsing: [ :each | each asString , '_' ]) allButLast asUppercase
]

{ #category : #parsing }
EDACMessageSerializer class >> nameWithoutPrefixForMessageClass: aMessageClass [
	^ aMessageClass asString allButFirst: (self eventClassPrefix: aMessageClass) size
]

{ #category : #parsing }
EDACMessageSerializer >> serialize: anEvent [
	self subclassResponsibility
]
