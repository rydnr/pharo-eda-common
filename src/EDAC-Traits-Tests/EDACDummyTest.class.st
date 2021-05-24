Class {
	#name : #EDACDummyTest,
	#superclass : #TestCase,
	#instVars : [
		'a',
		'b'
	],
	#category : #'EDAC-Traits-Tests'
}

{ #category : #tests }
EDACDummyTest >> testTautology [
	self assert: true
]
