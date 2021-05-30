Class {
	#name : #EDACTReflectionHelperTest,
	#superclass : #TestCase,
	#traits : 'EDACTReflectionHelper',
	#classTraits : 'EDACTReflectionHelper classTrait',
	#category : #'EDAC-Traits-Tests'
}

{ #category : #tests }
EDACTReflectionHelperTest >> testDoesInstanceUnderstand [
	self assert: (self doesInstance: self understand: #doesInstance:understand:)
]
