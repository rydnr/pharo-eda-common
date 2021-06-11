Class {
	#name : #EDACFuelHelper,
	#superclass : #Object,
	#category : #'EDAC-Fuel'
}

{ #category : #handling }
EDACFuelHelper >> readFuelFromFileNamed: aFileReference [
	| aContext |
	aContext := FLMaterializer
		materializeFromFileNamed: aFileReference pathString.
	^ Process forContext: aContext priority: Processor activePriority
]

{ #category : #handling }
EDACFuelHelper >> readFuelFromFileNamed: aString inFolder: aFolder [
	^ self readFuelFromFileNamed: (aFolder / aString)
]

{ #category : #handling }
EDACFuelHelper >> writeFuelContext: aContext named: aString inFolder: aFolder [
	| result |
	result := aFolder / aString.
	FLSerializer serialize: aContext toFileNamed: result pathString.
	^ result
]
