Trait {
	#name : #EDATRepository,
	#category : #'EDAC-Traits'
}

{ #category : #helpers }
EDATRepository classSide >> groupEventsById: events [
	| result |
	result := Dictionary new.
	events
		do: [ :evt | 
			result at: evt id ifPresent: [ :evts | evts add: evt ] ifAbsentPut: [ OrderedCollection with: evt ] .
].
	^ result
]
