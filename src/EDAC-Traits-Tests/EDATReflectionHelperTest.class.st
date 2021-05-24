Class {
	#name : #EDATReflectionHelperTest,
	#superclass : #TestCase,
	#traits : 'EDATReflectionHelper',
	#classTraits : 'EDATReflectionHelper classTrait',
	#category : #'EDAC-Traits-Tests'
}

{ #category : #tests }
EDATReflectionHelperTest >> testDoesInstanceUnderstand [
	self assert: (self doesInstance: self understand: #doesInstance:understand:)
]
