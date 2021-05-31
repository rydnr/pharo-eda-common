Trait {
	#name : #EDACDeepInspectHelper,
	#category : #'EDAC-Traits'
}

{ #category : #comparing }
EDACDeepInspectHelper >> areArrayOrCollectionBoth: firstVar and: secondVar [
	^ (self isArrayOrCollection: firstVar) and: [ self isArrayOrCollection: secondVar ]
]

{ #category : #comparing }
EDACDeepInspectHelper >> areDictionariesBoth: firstVar and: secondVar [
	^ (self isDictionary: firstVar) and: [ self isDictionary: secondVar ]
]

{ #category : #comparing }
EDACDeepInspectHelper >> deepEquals: anInstance [
	^ self deepEquals: self with: anInstance
]

{ #category : #comparing }
EDACDeepInspectHelper >> deepEquals: anInstance with: anotherInstance [
	| result |
	(self areArrayOrCollectionBoth: anInstance and: anotherInstance) ifTrue: [
		result := self deepEqualsArrayOrCollection: anInstance with: anotherInstance
	] ifFalse: [
		result := (anInstance class = anotherInstance class).
		result
			ifFalse: [
				result := (anInstance class isKindOf: anotherInstance class) or: [ anotherInstance class isKindOf: anInstance class ]
			].
		result ifTrue: [
			| myVarNames |
			myVarNames := anInstance class allInstVarNames.
			result := myVarNames = (anotherInstance class allInstVarNames)
		].
		result ifTrue: [
			result :=
				(anInstance class allInstVarNames reject: [ :varName |
					| myVar hisVar |
					myVar := (anInstance instVarNamed: varName).
					hisVar := (anotherInstance instVarNamed: varName).
					(self areDictionariesBoth: myVar and: hisVar)
						ifTrue: [
							self deepEqualsDictionary: myVar with: hisVar
						] ifFalse: [
							(self areArrayOrCollectionBoth: myVar and: hisVar)
								ifTrue: [
									self deepEqualsArrayOrCollection: myVar with: hisVar
								] ifFalse: [
									myVar = hisVar
								]
						]
				]) isEmpty
			]
		].
	^ result
]

{ #category : #comparing }
EDACDeepInspectHelper >> deepEqualsArrayOrCollection: anArrayOrCollection with: anotherArrayOrCollection [
	^ (self sizeIsEqualExcludingNils: anArrayOrCollection with: anotherArrayOrCollection)
		and: [ | first second aux |
			first := anArrayOrCollection reject: [ :v | v isNil ].
			second := anArrayOrCollection reject: [ :v | v isNil ].
			aux := OrderedCollection new.
			first	keysAndValuesDo: [ :i :v | 
				| w |
				w := second at: i.
				aux add:
					((self areArrayOrCollectionBoth: v and: w)
						ifTrue: [ self deepEqualsArrayOrCollection: v with: w ]
						ifFalse: [ self deepEquals: v with: w ])
			].
			(aux reject: [ :x | x ]) isEmpty
		]
]

{ #category : #comparing }
EDACDeepInspectHelper >> deepEqualsDictionary: aDict with: anotherDict [
	^ (aDict size = anotherDict size)
		and: [
			(aDict keys reject: [ :k |
				self deepEquals: (aDict at: k) with: (anotherDict at: k ifAbsent: [ nil ])
			]) isEmpty
		]
]

{ #category : #comparing }
EDACDeepInspectHelper >> isArrayOrCollection: aVar [
	^ (aVar class = Array) or: [ aVar isKindOf: OrderedCollection ]

]

{ #category : #comparing }
EDACDeepInspectHelper >> isDictionary: aVar [
	^ aVar class = Dictionary
]

{ #category : #comparing }
EDACDeepInspectHelper >> sizeIsEqualExcludingNils: anArrayOrCollection with: anotherArrayOrCollection [
	^ (anArrayOrCollection size = anotherArrayOrCollection size)
		or: [   (anArrayOrCollection reject: [ :v | v isNil ]) size
				= (anotherArrayOrCollection reject: [ :v | v isNil ]) size ]
]
