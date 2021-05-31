Trait {
	#name : #EDACRegexHelper,
	#category : #'EDAC-Traits'
}

{ #category : #helpers }
EDACRegexHelper classSide >> replaceIn: aString allMatches: regex with: replacement [
	^ regex asRegex copy: aString replacingMatchesWith: replacement asString
]

{ #category : #helpers }
EDACRegexHelper >> replaceIn: aValue allMatches: regex with: replacement [
	^ self class replaceIn: aValue allMatches: regex with: replacement
]
