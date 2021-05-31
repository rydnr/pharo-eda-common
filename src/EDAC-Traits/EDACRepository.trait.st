Trait {
	#name : #EDACRepository,
	#category : #'EDAC-Traits'
}

{ #category : #helpers }
EDACRepository classSide >> groupEventsById: events [
	| result |
	result := Dictionary new.
	events
		do: [ :evt | 
			result at: evt id ifPresent: [ :evts | evts add: evt ] ifAbsentPut: [ OrderedCollection with: evt ] .
].
	^ result
]
