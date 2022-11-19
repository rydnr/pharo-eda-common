Trait {
	#name : #EDACSourceCodeHelper,
	#traits : 'EDACReflectionHelper',
	#classTraits : 'EDACReflectionHelper classTrait',
	#category : #'EDAC-Traits'
}

{ #category : #helper }
EDACSourceCodeHelper >> allAttributesOf: cls [
	| result |
	result := OrderedCollection new.
	result addAll: cls instVarNames.
	^ result
]

{ #category : #helper }
EDACSourceCodeHelper >> allAttributesOf: cls including: attributes [
	| result |
	result := OrderedCollection withAll: attributes.
	result addAll: cls instVarNames.
	^ (Set withAll: result) asOrderedCollection 
]

{ #category : #helper }
EDACSourceCodeHelper >> asPharoSourceCode: anAttributeValue [
	| result cr |
	cr := String with: Character cr.
	(anAttributeValue isKindOf: Array)
		ifTrue: [ result := cr , '#('.
			anAttributeValue
				keysAndValuesDo: [ :i :item | 
					i > 1
						ifTrue: [ result := result , '.' ].
					result := result , (self asPharoSourceCode: item) , cr ].
			result := result , ') asOrderedCollection' ]
		ifFalse: [ (anAttributeValue isKindOf: Dictionary)
				ifTrue: [ result := cr , 'Dictionary newFrom: {'.
					anAttributeValue keys
						keysAndValuesDo: [ :i :item | 
							i > 1
								ifTrue: [ result := result , '.' ].
							result := result , cr , (self asPharoSourceCode: item) , ' -> '
								, (self asPharoSourceCode: (anAttributeValue at: item)) , cr ].
					result := result , '}' , cr ]
				ifFalse: [ result := (anAttributeValue isKindOf: String)
						ifTrue: [ $' greaseString , anAttributeValue , $' greaseString ]
						ifFalse: [ anAttributeValue greaseString ] ] ].
	^ result
]

{ #category : #helper }
EDACSourceCodeHelper >> camelCaseToDotSeparated: aString [
   ^ self separateCamelCase: aString with: '.'
]

{ #category : #compilation }
EDACSourceCodeHelper >> checkBytecodeHash: methodName sourceCode: method inClass: aClass [
	| existingClass existingMethod result |
	self flag: #TODO. "Two methods with different comments generate different bytecodes for some reason"
	existingClass := (self class environment at: aClass name asSymbol ifAbsent: nil).
	existingMethod := existingClass ifNil: [ nil ] ifNotNil: [ :c | c methodDictionary at: methodName asSymbol ifAbsent: [ nil ] ].
	result := existingMethod isNotNil.
	result
		ifTrue: [ | tempClass generatedMethod |
			tempClass := Object
				subclass: (aClass greaseString , 'Temp') asSymbol
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'EDA-Tools-Temp'.
			tempClass compile: method classified: #temp.
			generatedMethod := tempClass methodDictionary at: methodName asSymbol.
			result := generatedMethod bytecodesHash = existingMethod bytecodesHash.
			tempClass removeFromSystem ].
	^ result
]

{ #category : #helper }
EDACSourceCodeHelper >> commandNameFor: anEventName [
	^ self commandNameFor: anEventName withSeparator: '.'
]

{ #category : #helper }
EDACSourceCodeHelper >> commandNameFor: aCommandName usingCommandNameResolver: aCommandNameResolver [
	^ aCommandNameResolver resolve: aCommandName
]

{ #category : #helper }
EDACSourceCodeHelper >> commandNameFor: anEventName withSeparator: separator [
	| result aux |
	result := nil.
	aux := anEventName allRegexMatches: '([^' , separator , ']*)'.
	aux size > 2
		ifTrue: [ | past rest present |
			rest := aux allButLast allButLast.
			past := aux allButLast last.
			present := self verbInPresentTense: past.
			result := ''.
			rest
				keysAndValuesDo: [ :i :noun | 
					i < rest size
						ifTrue: [ result := result , separator ].
					result := result , noun ].
			result := present , separator , result ].
	^ result
]

{ #category : #compilation }
EDACSourceCodeHelper >> compile: methodName sourceCode: method inClass: aClass classifiedAs: protocol [
	| compile |
	self flag: #TODO. "Disabled checkBytecodeHash:sourceCode:inClass: since it doesn't help figuring out if a method changes only by a signature timestamp"
	compile := (self isMethod: methodName markedAsDisableRegenerationInClass: aClass) not.
	"compile := compile
		ifTrue: [ (self checkBytecodeHash: methodName sourceCode: method inClass: aClass) not ]
		ifFalse: [ false ]."
	compile
		ifTrue: [ | existingMethod |
			existingMethod := aClass methodDictionary at: methodName asSymbol ifAbsent: [ nil ].
			existingMethod ifNil: [ compile := true ] ifNotNil: [ :m | compile := m protocol greaseString beginsWithSubCollection: 'generated' ] ].
	compile
		ifTrue: [ aClass compile: method classified: protocol ]
]

{ #category : #compilation }
EDACSourceCodeHelper >> compileIfDoesNotExist: methodName sourceCode: method inClass: aClass classifiedAs: protocol [
	aClass methodDictionary
		at: methodName asSymbol
		ifAbsent: [ self
				compile: methodName
				sourceCode: method
				inClass: aClass
				classifiedAs: protocol ]
]

{ #category : #'compilation-support' }
EDACSourceCodeHelper >> containsAnyDisableRegenerationMethod: aClass [
	^ (self retrieveDisableRegenerationPragmas: aClass) isNotEmpty
]

{ #category : #helper }
EDACSourceCodeHelper >> cr [
	^ Character cr
]

{ #category : #helper }
EDACSourceCodeHelper >> csvToCollection: aString [
	^ EDACCollectionHelper csvToCollection: aString
]

{ #category : #helper }
EDACSourceCodeHelper >> dotSeparatedToCamelCase: aString [
	^ self toCamelCase: aString usingSeparator: '\.'

]

{ #category : #helper }
EDACSourceCodeHelper >> eventNameFor: aCommandName usingEventNameResolver: anEventNameResolver [
	^ anEventNameResolver resolve: aCommandName
]

{ #category : #helper }
EDACSourceCodeHelper >> generateSignature [
	| fromCommand file |
	self flag: #TODO. "Disabled since it generates conflicts in git, and checkBytecodeHash:sourceCode:inClass: is not useful for figuring out if the method actually changes."
	fromCommand := self commandFile isNotNil.
	file := fromCommand
		ifTrue: [ self commandFile ]
		ifFalse: [ self eventFile ].
	"^ '	""Generated by ' , self class greaseString , '>>' , thisContext sender selector , ' for ' , self aggregate , ' aggregate from file ' , file fullPath basename , ' at '
		, DateAndTime now asUTC greaseString , ' ""' , (String with: Character cr)"
	^ String with: Character cr
]

{ #category : #helper }
EDACSourceCodeHelper >> generatedProtocolFor: aNumber [
	| result |
	result := (aNumber
		ifNil: [ 'generated' ]
		ifNotNil: [ :arg | 'generated-v' , arg greaseString ]) asSymbol.
	^ result
]

{ #category : #helper }
EDACSourceCodeHelper >> isAggregate: aSymbol [
	"Override me with extension methods if needed"
	^ false
]

{ #category : #'compilation-support' }
EDACSourceCodeHelper >> isMethod: aMethodName markedAsDisableRegenerationInClass: aClass [
	^ (aClass methodDictionary at: aMethodName asSymbol ifAbsent: [ ^ false ]) hasPragmaNamed: 'disable_regeneration'
]

{ #category : #helper }
EDACSourceCodeHelper >> lowcased: aString andSeparatedBy: aSeparator [

	| aux |
	aux := '_' asRegexIgnoringCase
		       copy: aString
		       replacingMatchesWith: aSeparator.
	^ aux asLowercase
]

{ #category : #helper }
EDACSourceCodeHelper >> lowcasedToDashSeparatedBy: aString [

	^ self lowcased: aString andSeparatedBy: '-'
]

{ #category : #helper }
EDACSourceCodeHelper >> lowcasedToDotSeparatedBy: aString [

	^ self lowcased: aString andSeparatedBy: '.'
]

{ #category : #helper }
EDACSourceCodeHelper >> normalize: aString [
	^ (self replace: '\W' with: '_' inString: aString trimmed) asLowercase
]

{ #category : #helper }
EDACSourceCodeHelper >> remove: prefix fromBeginningOf: aString [
	| result |
	result := (aString beginsWithSubCollection: prefix) ifTrue: [ aString copyReplaceFrom: 1 to: prefix size with: '' ] ifFalse: [ aString ].
	^ result
]

{ #category : #helper }
EDACSourceCodeHelper >> removeClassLiteralFromMetaClassName: aString [
	^ ' class$' asRegexIgnoringCase copy: aString replacingMatchesWith: ''
]

{ #category : #helper }
EDACSourceCodeHelper >> removeSuffix: suffix fromFileName: aFile [
	^ aFile basename copyWithRegex: (suffix copyWithRegex: '\.' matchesReplacedWith: '\.') , '$' matchesReplacedWith: ''
]

{ #category : #helper }
EDACSourceCodeHelper >> replace: match with: replacement inString: aString [
	^ match asRegexIgnoringCase copy: aString replacingMatchesWith: replacement
]

{ #category : #helper }
EDACSourceCodeHelper >> retrieveAggregateFromAggregateKey: json [
	| result aux |
	aux := (json at: #meta) at: #aggregate ifAbsent: [ nil ].
	result := aux ifNil: [ nil ] ifNotNil: [ :arg | aux asCamelCase ].
	^ result
]

{ #category : #helper }
EDACSourceCodeHelper >> retrieveAggregateFromCommandType: json [
	| result type aux |
	result := nil.
	aux := (json at: #meta) at: #type ifAbsent: [ nil ].
	aux 
		ifNotNil: [ :arg | 
			type := aux allRegexMatches: '([^_]*)'.
			type
				do: [ :word | 
					(self isAggregate: word)
						ifTrue: [ result := self toCamelCase: word asCamelCase ] ] ].
	^ result
]

{ #category : #'compilation-support' }
EDACSourceCodeHelper >> retrieveDisableRegenerationPragmas: aClass [
	^ self retrieveMethodsInClass: aClass withPragma: 'disable_regeneration'

]

{ #category : #'compilation-support' }
EDACSourceCodeHelper >> retrieveMethodsInClass: aClass withPragma: aPragma [
	(self classExists: aClass asSymbol)
		ifTrue: [ ^ (Pragma
				allNamed: aPragma
				in: (self class environment at: aClass asSymbol)) collect: [ :pragma | pragma method ] ]
		ifFalse: [ ^ #() ]
]

{ #category : #helper }
EDACSourceCodeHelper >> separateCamelCase: aString with: aSeparator [
   ^ (aString copyWithRegex: '[A-Z]' matchesTranslatedUsing: [ :each | aSeparator , each asLowercase  ]) allButFirst 
]

{ #category : #helper }
EDACSourceCodeHelper >> toCamelCase: aString [
	^ self underscoreSeparatedToCamelCase: aString asCamelCase 
]

{ #category : #helper }
EDACSourceCodeHelper >> toCamelCase: aString usingSeparator: separator [
	| aux result |
	aux := separator asRegexIgnoringCase copy: aString replacingMatchesWith: ' '.
	result := aux = aux asUppercase 
		ifTrue: [ aux asLowercase asCamelCase ]
		ifFalse: [ aux asCamelCase  ].
	^ result
]

{ #category : #helper }
EDACSourceCodeHelper >> underscoreSeparatedToCamelCase: aString [
	^ self toCamelCase: aString usingSeparator: '_'

]

{ #category : #helper }
EDACSourceCodeHelper >> upcased: aString andSeparatedBy: aSeparator [

	| aux |
	aux := '_' asRegexIgnoringCase
		       copy: aString
		       replacingMatchesWith: aSeparator.
	^ aux asLowercase
]

{ #category : #helper }
EDACSourceCodeHelper >> upcasedToDashSeparated: aString [

	^ self upcased: aString andSeparatedBy: '-'
]

{ #category : #helper }
EDACSourceCodeHelper >> upcasedToDotSeparated: aString [

	^ self upcased: aString andSeparatedBy: '.'
]
