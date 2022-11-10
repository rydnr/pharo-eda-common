Class {
	#name : #EDACLoggingSettings,
	#superclass : #Object,
	#classInstVars : [
		'debugEnabled',
		'infoEnabled',
		'errorEnabled',
		'warningEnabled',
		'loggingLevel',
		'traceEnabled'
	],
	#category : #'EDAC-Logging'
}

{ #category : #accessing }
EDACLoggingSettings class >> debugEnabled [
	^ debugEnabled
]

{ #category : #accessing }
EDACLoggingSettings class >> debugEnabled: aBoolean [
	debugEnabled := aBoolean.
	aBoolean
		ifTrue: [ self infoEnabled: true ]
]

{ #category : #'class initialization' }
EDACLoggingSettings class >> doInitialize [

	self loggingLevel: 'debug'
]

{ #category : #accessing }
EDACLoggingSettings class >> errorEnabled [
	^ errorEnabled
]

{ #category : #accessing }
EDACLoggingSettings class >> errorEnabled: aBoolean [
	errorEnabled := aBoolean
]

{ #category : #accessing }
EDACLoggingSettings class >> infoEnabled [
	^ infoEnabled
]

{ #category : #accessing }
EDACLoggingSettings class >> infoEnabled: aBoolean [
	infoEnabled := aBoolean.
	aBoolean
		ifTrue: [ self warningEnabled: true ]
]

{ #category : #'class initialization' }
EDACLoggingSettings class >> initialize [
	self doInitialize
]

{ #category : #accessing }
EDACLoggingSettings class >> levels [
	^ #('trace' 'debug' 'info' 'warning' 'error')
]

{ #category : #accessing }
EDACLoggingSettings class >> loggingLevel [
	^ loggingLevel
]

{ #category : #accessing }
EDACLoggingSettings class >> loggingLevel: aLevel [
	| failed |
	failed := true.
	self traceEnabled: (aLevel = 'trace').
	self debugEnabled: (self traceEnabled or: [ (aLevel = 'debug') ]).
	self infoEnabled: (self debugEnabled or: [ (aLevel = 'info') ]).
	self warningEnabled: (self infoEnabled or: [  (aLevel = 'warning') ]).
	self errorEnabled: (self warningEnabled or: [ (aLevel = 'error') ]).
	failed := (self traceEnabled or: [ self debugEnabled or: [ self infoEnabled or: [ self warningEnabled or: [ self errorEnabled  ] ] ] ]) not.
	failed
		ifTrue: [ EDACInvalidLoggingLevel signal ]
		ifFalse: [ loggingLevel := aLevel ]

]

{ #category : #accessing }
EDACLoggingSettings class >> traceEnabled [
	^ traceEnabled
]

{ #category : #accessing }
EDACLoggingSettings class >> traceEnabled: aBoolean [
	traceEnabled := aBoolean.
	aBoolean
		ifTrue: [ self debugEnabled: true ]
]

{ #category : #accessing }
EDACLoggingSettings class >> warningEnabled [
	^ warningEnabled
]

{ #category : #accessing }
EDACLoggingSettings class >> warningEnabled: aBoolean [
	warningEnabled := aBoolean.
	aBoolean
		ifTrue: [ self errorEnabled: true ]
]
