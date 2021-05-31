Trait {
	#name : #EDACLanguageHelper,
	#category : #'EDAC-Traits'
}

{ #category : #helper }
EDACLanguageHelper classSide >> irregularPastTenses: aVerb [
	| result dict |
	dict := {('build' -> 'built').
	('send' -> 'sent').
	('submit' -> 'submitted')} asDictionary.
	result := dict at: aVerb asLowercase ifAbsent: [ nil ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDACLanguageHelper classSide >> irregularPluralFormFor: aNoun [
	| mapping |
	mapping := Dictionary new.
	mapping at: 'bus' put: 'buses'.
	mapping keysAndValuesDo: [ :key :value | mapping at: value put: value ].
	^ mapping at: aNoun ifAbsent: [ nil ]
]

{ #category : #helper }
EDACLanguageHelper classSide >> irregularPresentTenses: aVerb [
	| result dict |
	dict := {('built' -> 'build').
	('sent' -> 'send').
	('submitted' -> 'submit')} asDictionary.
	result := dict at: aVerb asLowercase ifAbsent: [ nil ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDACLanguageHelper classSide >> irregularSingularFormFor: aNoun [
	| mapping |
	mapping := Dictionary new.
	mapping at: 'buses' put: 'bus'.
	mapping keysAndValuesDo: [ :key :value | mapping at: value put: value ].
	^ mapping at: aNoun ifAbsent: [ nil ]
]

{ #category : #helper }
EDACLanguageHelper classSide >> nounInPlural: aNoun [
	| result |
	result := self irregularPluralFormFor: aNoun.
	result
		ifNil: [ result := (aNoun matchesRegexIgnoringCase: '.*y$')
				ifTrue: [ (self removeSuffix: 'y' from: aNoun) , 'ies' ]
				ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*es$')
						ifTrue: [ aNoun ]
						ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*s$')
								ifTrue: [ aNoun ]
								ifFalse: [ aNoun , 's' ] ] ] ].
	result
		ifNotNil: [ :arg | 
			aNoun = aNoun asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDACLanguageHelper classSide >> nounInSingular: aNoun [
	| result |
	result := self irregularSingularFormFor: aNoun.
	result
		ifNil: [ result := (aNoun matchesRegexIgnoringCase: '.*ies$')
				ifTrue: [ (self removeSuffix: 'ies' from: aNoun) , 'y' ]
				ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*es$')
						ifTrue: [ self removeSuffix: 's' from: aNoun ]
						ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*s$')
								ifTrue: [ self removeSuffix: 's' from: aNoun ]
								ifFalse: [ aNoun ] ] ] ].
	result
		ifNotNil: [ :arg | 
			aNoun = aNoun asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #removing }
EDACLanguageHelper classSide >> removePrefix: prefix from: value [
	^ ('^' , prefix copyReplaceAll: ':' with: '\:') asRegexIgnoringCase copy: value replacingMatchesWith: ''
]

{ #category : #removing }
EDACLanguageHelper classSide >> removeSuffix: suffix from: value [
	^ ((suffix copyReplaceAll: ':' with: '\:') , '$') asRegexIgnoringCase copy: value replacingMatchesWith: ''
]

{ #category : #helper }
EDACLanguageHelper classSide >> verbInPastTense: aVerb [
	| result |
	result := self irregularPastTenses: aVerb.
	result
		ifNil: [ result := (aVerb matchesRegexIgnoringCase: '.*([aeiou])$')
				ifTrue: [ aVerb , 'd' ]
				ifFalse: [ aVerb , 'ed' ] ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDACLanguageHelper classSide >> verbInPresentTense: aVerb [
	| result |
	result := self irregularPresentTenses: aVerb.
	result
		ifNil: [ result := (aVerb matchesRegexIgnoringCase: '.*ed$')
				ifTrue: [ self removeSuffix: 'd' from: aVerb ]
				ifFalse: [ self removeSuffix: 'd' from: aVerb ] ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result
]

{ #category : #helper }
EDACLanguageHelper >> irregularPastTenses: aVerb [
	^ self class irregularPastTenses: aVerb
]

{ #category : #helper }
EDACLanguageHelper >> irregularPluralFormFor: aNoun [
	^ self class irregularPluralFormFor: aNoun
	
]

{ #category : #helper }
EDACLanguageHelper >> irregularPresentTenses: aVerb [
	^ self class irregularPresentTenses: aVerb

]

{ #category : #helper }
EDACLanguageHelper >> irregularSingularFormFor: aNoun [
	^ self class irregularSingularFormFor: aNoun

]

{ #category : #helper }
EDACLanguageHelper >> nounInPlural: aNoun [
	^ self class nounInPlural: aNoun

]

{ #category : #helper }
EDACLanguageHelper >> nounInSingular: aNoun [
	^ self class nounInSingular: aNoun

]

{ #category : #helper }
EDACLanguageHelper >> removePrefix: prefix from: value [
	^ self class removePrefix: prefix from: value

]

{ #category : #helper }
EDACLanguageHelper >> removeSuffix: suffix from: value [
	^ self class removeSuffix: suffix from: value

]

{ #category : #helper }
EDACLanguageHelper >> verbInPastTense: aVerb [
	^ self class verbInPastTense: aVerb

]

{ #category : #helper }
EDACLanguageHelper >> verbInPresentTense: aVerb [
	^ self class verbInPresentTense: aVerb

]
