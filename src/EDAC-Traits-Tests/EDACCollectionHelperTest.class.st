Class {
	#name : #EDACCollectionHelperTest,
	#superclass : #TestCase,
	#traits : 'EDACCollectionHelper',
	#classTraits : 'EDACCollectionHelper classTrait',
	#category : #'EDAC-Traits-Tests'
}

{ #category : #tests }
EDACCollectionHelperTest >> testCsvToCollectionTrims [
	| sample actual expected |
	sample := 'a ,   b ,c'.
	expected := OrderedCollection with: 'a' with: 'b' with: 'c'.
	actual := self csvToCollection: sample.
	self assert: actual equals: expected
]

{ #category : #tests }
EDACCollectionHelperTest >> testCsvToCollectionTrivial [
	| sample actual expected |
	sample := 'a,b,c'.
	expected := OrderedCollection with: 'a' with: 'b' with: 'c'.
	actual := self csvToCollection: sample.
	self assert: actual equals: expected
]

{ #category : #tests }
EDACCollectionHelperTest >> testFlatten [
	| sample a b c d e actual expected |
	a := 'a'.
	b := {('1' -> 'a').
	('2' -> 'A')} asDictionary.
	c := OrderedCollection with: b.
	d := OrderedCollection with: 'd' with: c.
	e := {('x' -> '3').
	('y' -> '4')} asDictionary.
	sample := OrderedCollection
		with: a
		with: b
		with: c
		with: d
		with: e.
	expected := OrderedCollection
		with: 'a'
		with: b
		with: b
		with: 'd'
		with: b
		with: e.
	actual := self flatten: sample.
	self assert: actual equals: expected
]

{ #category : #tests }
EDACCollectionHelperTest >> testRemoveDuplicatesInMatching [
	| fixture trimmed |
	fixture := {{('id' -> 'foo').
	('field' -> 'something')} asDictionary.
	{('id' -> 'foo').
	('extra' -> 'bar')} asDictionary.
	{('id' -> 'item1').
	('value' -> 'something')} asDictionary} asOrderedCollection.
	trimmed := self removeDuplicatesIn: fixture matching: [ :first :second | (first at: 'id') = (second at: 'id') ].
	self assert: trimmed isNotNil.
	self assert: trimmed size = 2
]
