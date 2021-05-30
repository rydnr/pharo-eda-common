Trait {
	#name : #EDACTRegexHelper,
	#category : #'EDAC-Traits'
}

{ #category : #helpers }
EDACTRegexHelper classSide >> replaceIn: aString allMatches: regex with: replacement [
	^ regex asRegex copy: aString replacingMatchesWith: replacement asString
]

{ #category : #helpers }
EDACTRegexHelper >> replaceIn: aValue allMatches: regex with: replacement [
	^ self class replaceIn: aValue allMatches: regex with: replacement
]
