Trait {
	#name : #EDACTCollectionHelper,
	#category : #'EDAC-Traits'
}

{ #category : #helper }
EDACTCollectionHelper classSide >> concatenateCollection: aCollection with: aSeparator [
	| txt |
	txt := ''.
	aCollection
		keysAndValuesDo: [ :i :item | 
			i > 1
				ifTrue: [ txt := txt , aSeparator ].
			txt := txt , item ].
	^ txt
]

{ #category : #helper }
EDACTCollectionHelper classSide >> csvToCollection: aString [
	| result |
	result := OrderedCollection new.
	aString splitOn: ',' do: [ :s | result add: s trim ].
	^ result
]

{ #category : #helper }
EDACTCollectionHelper classSide >> flatten: aCollection [
	| result |
	result := OrderedCollection new.
	aCollection
		do: [ :item | 
			(item isCollection or: [ item isArray ])
				ifTrue: [ result addAll: (self flatten: item) ]
				ifFalse: [ result add: item ] ].
	^ result
]

{ #category : #helper }
EDACTCollectionHelper classSide >> removeDuplicatesIn: aCollection matching: aBlock [
	| result duplicates |
	duplicates := aCollection
		select:
			[ :it | (aCollection count: [ :el | aBlock value: it value: el ]) > 1 ].
	result := (aCollection
		collect: [ :it | 
			(duplicates includes: it)
				ifTrue: [ (duplicates select: [ :el | aBlock value: it value: el ]) first = it
						ifTrue: [ it ]
						ifFalse: [ nil ] ]
				ifFalse: [ it ] ]) select: [ :it | it isNotNil ].
	^ result
]

{ #category : #helper }
EDACTCollectionHelper >> concatenateCollection: aCollection with: aSeparator [
	^ self class concatenateCollection: aCollection with: aSeparator

]

{ #category : #helper }
EDACTCollectionHelper >> csvToCollection: aString [
	^ self class csvToCollection: aString
]

{ #category : #helper }
EDACTCollectionHelper >> flatten: aCollection [
	^ self class flatten: aCollection
]

{ #category : #helper }
EDACTCollectionHelper >> removeDuplicatesIn: aCollection matching: aBlock [
	^ self class removeDuplicatesIn: aCollection matching: aBlock
]
