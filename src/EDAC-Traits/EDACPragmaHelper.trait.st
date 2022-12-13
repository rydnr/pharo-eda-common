Trait {
	#name : #EDACPragmaHelper,
	#category : #'EDAC-Traits'
}

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragma: aSymbol in: aClass [

	| candidates |
	candidates := self
		              retrievePragmas: aSymbol
		              in: aClass
		              ifEmpty: [ :s :c |  ].
	candidates size > 1 ifTrue: [ 
		| message |
		message := String new streamContents: [ :str | 
			           str
				           nextPutAll: 'More than one pragma <';
				           nextPutAll: aSymbol greaseString;
				           nextPutAll: '> found: '.
			           candidates
				           do: [ :c | str nextPutAll: c selector greaseString ]
				           separatedBy: [ str nextPutAll: ', ' ] ].
		self errorClass signal: message ].
	^ candidates size = 1 ifTrue: [ candidates first ] ifFalse: [ nil ]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragma: aSymbol in: aClass upTo: aSuperClass [

	| candidates |
	candidates := self
		              retrievePragmas: aSymbol
		              in: aClass
		              upTo: aSuperClass
		              ifEmpty: [ :s :c :u |  ].
	candidates size > 1 ifTrue: [ 
		| message |
		message := String new streamContents: [ :str | 
			           str
				           nextPutAll: 'More than one pragma <';
				           nextPutAll: aSymbol greaseString;
				           nextPutAll: '> found: '.
			           candidates
				           do: [ :c | str nextPutAll: c selector greaseString ]
				           separatedBy: [ str nextPutAll: ', ' ] ].
		self errorClass signal: message ].
	^ candidates size = 1
		  ifTrue: [ candidates first ]
		  ifFalse: [ nil ]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragma: aSymbol inAndBelow: aClass [

	| candidates |
	candidates := self
		              retrievePragmas: aSymbol
		              inAndBelow: aClass
		              ifEmpty: [ :s :c |  ].
	candidates size > 1 ifTrue: [ 
		| message |
		message := String new streamContents: [ :str | 
			           str
				           nextPutAll: 'More than one pragma <';
				           nextPutAll: aSymbol greaseString;
				           nextPutAll: '> found: '.
			           candidates
				           do: [ :c | str nextPutAll: c selector greaseString ]
				           separatedBy: [ str nextPutAll: ', ' ] ].
		self errorClass signal: message ].
	^ candidates = 1 ifTrue: [ candidates first ] ifFalse: [ nil ]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragma: aSymbol with: aValue in: aClass upTo: aSuperClass [

	| candidates |
	candidates := self
		              retrievePragmas: aSymbol
		              with: aValue
		              in: aClass
		upTo: aSuperClass
		              ifEmpty: [ :s :v :c |  ].
	candidates size > 1 ifTrue: [ 
		| message |
		message := String new streamContents: [ :str | 
			           str
				           nextPutAll: 'More than one pragma <';
				           nextPutAll: aSymbol greaseString;
				           nextPut: Character space;
				           nextPutAll: aValue greaseString;
				           nextPutAll: '> found: '.
			           candidates
				           do: [ :c | str nextPutAll: c selector greaseString ]
				           separatedBy: [ str nextPutAll: ', ' ] ].
		self errorClass signal: message ].
	^ candidates size = 1
		  ifTrue: [ candidates first ]
		  ifFalse: [ nil ]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragma: aSymbol with: aValue inAndBelow: aClass [

	| candidates |
	candidates := self
		              retrievePragmas: aSymbol
		              with: aValue
		              inAndBelow: aClass
		              ifEmpty: [ :s :v :c |  ].
	candidates size > 1 ifTrue: [ 
		| message |
		message := String new streamContents: [ :str | 
			           str
				           nextPutAll: 'More than one pragma <';
				           nextPutAll: aSymbol greaseString;
				           nextPut: Character space;
				           nextPutAll: aValue greaseString;
				           nextPutAll: '> found: '.
			           candidates
				           do: [ :c | str nextPutAll: c selector greaseString ]
				           separatedBy: [ str nextPutAll: ', ' ] ].
		self errorClass signal: message ].
	^ candidates size = 1 ifTrue: [ candidates first ] ifFalse: [ nil ]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol in: aClass [

	^ self retrievePragmas: aSymbol in: aClass ifEmpty: [ :s :c |
		  self errorClass new signal:
			  'No pragma <' , s greaseString , '> found in '
			  , c greaseString ]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol in: aClass ifEmpty: aBlock [

	| result |
	result := Pragma allNamed: aSymbol in: aClass.
	aBlock value: aSymbol value: aClass.
	^ result
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol in: aClass upTo: aSuperClass [

	^ self
		  retrievePragmas: aSymbol
		  in: aClass
		  upTo: aSuperClass
		  ifEmpty: [ :s :c :u | 
			  self errorClass new signal:
				  'No pragma <' , s greaseString , '> found in ' , c greaseString , ' up to ' , u greaseString]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol in: aClass upTo: aSuperClass ifEmpty: aBlock [

	| result |
	result := Pragma allNamed: aSymbol from: aClass to: aSuperClass.
	aBlock value: aSymbol value: aClass value: aSuperClass.
	^ result
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol inAndBelow: aClass [

	^ self
		  retrievePragmas: aSymbol
		  inAndBelow: aClass
		  ifEmpty: [ :s :c | 
			  self errorClass new signal:
				  'No pragma <' , s greaseString , '> found in ', c greaseString ]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol inAndBelow: aClass ifEmpty: aBlock [

	| result |
	result := Pragma allNamed: aSymbol inAndBelow: aClass.
	aBlock value: aSymbol value: aClass.
	^ result
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol with: aValue in: aClass upTo: aSuperClass [

	^ self
		  retrievePragmas: aSymbol
		  with: aValue
		  in: aClass
		  upTo: aSuperClass
		  ifEmpty: [ :s :v :c :u | 
			  self errorClass new signal:
				  'No pragma <' , s greaseString , ' ' , v greaseString
				  , '> found in ' , c greaseString , ' up to ' , u greaseString]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol with: aValue in: aClass upTo: aSuperClass ifEmpty: aBlock [

	| result |
	result := (Pragma allNamed: aSymbol from: aClass to: aSuperClass) 
		          select: [ :p | (p argumentAt: 1) = aValue ].
	aBlock value: aSymbol value: aValue value: aClass value: aSuperClass.
	^ result
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol with: aValue inAndBelow: aClass [

	^ self retrievePragmas: aSymbol with: aValue inAndBelow: aClass ifEmpty: [ :s :v :c |

		self errorClass new signal:
			'No pragma <' , s greaseString , ' ' , v greaseString
			, '> found in ', c greaseString ]
]

{ #category : #pragmas }
EDACPragmaHelper classSide >> retrievePragmas: aSymbol with: aValue inAndBelow: aClass ifEmpty: aBlock [

	| result |
	result := (Pragma allNamed: aSymbol inAndBelow: aClass) select: [ :p | 
		          (p argumentAt: 1) = aValue ].
	aBlock value: aSymbol value: aValue value: aClass.
	^ result
]

{ #category : #pragmas }
EDACPragmaHelper >> retrievePragma: aSymbol in: aClass [

	^ self class retrievePragma: aSymbol in: aClass
]

{ #category : #pragmas }
EDACPragmaHelper >> retrievePragma: aSymbol in: aClass upTo: aSuperClass [

	^ self class retrievePragma: aSymbol in: aClass upTo: aSuperClass
]

{ #category : #pragmas }
EDACPragmaHelper >> retrievePragma: aSymbol inAndBelow: aClass [
	^ self class retrievePragma: aSymbol inAndBelow: aClass
]

{ #category : #pragmas }
EDACPragmaHelper >> retrievePragma: aSymbol with: aValue in: aClass upTo: aSuperClass [

	^ self class retrievePragma: aSymbol with: aValue in: aClass upTo: aSuperClass
]

{ #category : #pragmas }
EDACPragmaHelper >> retrievePragma: aSymbol with: aValue inAndBelow: aClass [
	^ self class retrievePragma: aSymbol with: aValue inAndBelow: aClass
]

{ #category : #pragmas }
EDACPragmaHelper >> retrievePragmas: aSymbol in: aClass upTo: aSuperClass [

	^ self class retrievePragmas: aSymbol in: aClass upTo: aSuperClass
]

{ #category : #pragmas }
EDACPragmaHelper >> retrievePragmas: aSymbol inAndBelow: aClass [
	^ self class retrievePragmas: aSymbol inAndBelow: aClass
]

{ #category : #pragmas }
EDACPragmaHelper >> retrievePragmas: aSymbol with: aValue in: aClass upTo: aSuperClass [

	^ self class retrievePragmas: aSymbol with: aValue in: aClass upTo: aSuperClass
]

{ #category : #pragmas }
EDACPragmaHelper >> retrievePragmas: aSymbol with: aValue inAndBelow: aClass [
	^ self class retrievePragmas: aSymbol with: aValue inAndBelow: aClass
]
