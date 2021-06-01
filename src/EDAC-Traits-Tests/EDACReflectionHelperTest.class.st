Class {
	#name : #EDACReflectionHelperTest,
	#superclass : #TestCase,
	#traits : 'EDACReflectionHelper',
	#classTraits : 'EDACReflectionHelper classTrait',
	#category : #'EDAC-Traits-Tests'
}

{ #category : #tests }
EDACReflectionHelperTest >> testDoesInstanceUnderstand [
	self assert: (self doesInstance: self understand: #doesInstance:understand:)
]
