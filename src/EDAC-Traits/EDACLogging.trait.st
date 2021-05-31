"
Class

- I am a trait that injects logging methods for any class to use.

Responsibility

- I provide a simple logging mechanism, avoiding polluting Transcript logic everywhere.

Collaborators

- I delegate the logging to Transcript.

Public API and Key Messages

- logDebugMessage: logs a message under the ""DEBUG"" category. Only 10% of these messages get logged instantly.
- logErrorMessage: logs a message under the ""ERROR"" category, instantly.
- logErrorMessage:andThrow: logs a message under the ""ERROR"" category  and throws an exception, instantly.
- logInfoMessage: logs a message under the ""INFO"" category, instantly.
- logWarningMessage: logs a message under the ""WARN"" category, instantly.

To use me, you just need to ""use"" me. I'm a trait.

Internal Representation and Key Implementation Points.

I'm a trait, so I don't have state. This means I'm pretty limited unless I can access to an external entity I could use to customize my behavior.
So far such entity doesn't exist, and meanwhile I log everything to Transcript and flush it inmediately, but for DEBUG messages. Such messages get flushed every once in 10, in average.
"
Trait {
	#name : #EDACLogging,
	#category : #'EDAC-Traits'
}

{ #category : #logging }
EDACLogging classSide >> beautifyByDefault [
	^ true
]

{ #category : #logging }
EDACLogging classSide >> defaultStream [
	^ self stdout
]

{ #category : #logging }
EDACLogging classSide >> logDebugMessage: aMessage [
	^ self logDebugMessage: aMessage beautify: self beautifyByDefault
]

{ #category : #logging }
EDACLogging classSide >> logDebugMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings debugEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'DEBUG'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACLogging classSide >> logErrorMessage: aMessage [
	^ self logErrorMessage: aMessage beautify: self beautifyByDefault
]

{ #category : #logging }
EDACLogging classSide >> logErrorMessage: aMessage andThrow: anExceptionClass [
	^ self logErrorMessage: aMessage beautify: self beautifyByDefault andThrow: anExceptionClass
]

{ #category : #logging }
EDACLogging classSide >> logErrorMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings errorEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'ERROR'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACLogging classSide >> logErrorMessage: aMessage beautify: aBoolean andThrow: anExceptionClass [
	self logErrorMessage: aMessage beautify: aBoolean.
	anExceptionClass signal: aMessage
]

{ #category : #logging }
EDACLogging classSide >> logInfoMessage: aMessage [
	^ self logInfoMessage: aMessage beautify: self beautifyByDefault 
]

{ #category : #logging }
EDACLogging classSide >> logInfoMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings infoEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'INFO '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACLogging classSide >> logMessage: aMessage inCategory: aString inStream: aStream [
	^ self logMessage: aMessage inCategory: aString inStream: aStream beautify: self beautifyByDefault 
]

{ #category : #logging }
EDACLogging classSide >> logMessage: aMessage inCategory: aString inStream: aStream beautify: beautify [
	| timestamp stream |
	stream := WriteStream on: String new.
	beautify
		ifTrue: [ stream << '['.
			timestamp := DateAndTime now.
			timestamp printYMDOn: stream.
			stream << '|'.
			timestamp printHMSOn: stream.
			stream << ']['.
			stream << aString asUppercase.
			stream << '] ' ].
	aMessage ifNotNil: [ :msg | stream nextPutAll: msg ].
	beautify
		ifTrue: [ (aMessage endsWithSubCollection: '.')
				ifFalse: [ stream << '.' ] ].
	stream nextPut: Character cr.
	stream nextPut: Character lf.
	aStream
		<< stream contents;
		nextPut: Character cr.
	(aString = 'ERROR'
		or: [ aString = 'WARN ' or: [ aString = 'INFO ' or: [ DateAndTime now seconds % 10 = 0 ] ] ])
		ifTrue: [ aStream flush ]
]

{ #category : #logging }
EDACLogging classSide >> logTraceMessage: aMessage [
	^ self logTraceMessage: aMessage beautify: self beautifyByDefault 
]

{ #category : #logging }
EDACLogging classSide >> logTraceMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings traceEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'TRACE'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACLogging classSide >> logWarningMessage: aMessage [
	^ self logWarningMessage: aMessage beautify: self beautifyByDefault
]

{ #category : #logging }
EDACLogging classSide >> logWarningMessage: aMessage beautify: aBoolean [
	^ EDACLoggingSettings warningEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'WARN '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACLogging classSide >> nextPut: aCharacter [
	| result |
	result := self defaultStream.
	result nextPut: aCharacter.
	^ result
]

{ #category : #logging }
EDACLogging classSide >> nextPutAll: aString [
	| result |
	result := self defaultStream.
	result nextPutAll: aString.
	^ result
]

{ #category : #logging }
EDACLogging classSide >> print: aString [
	| result |
	result := self defaultStream.
	result print: aString.
	^ result
]

{ #category : #logging }
EDACLogging classSide >> stderr [
	^ Stdio stderr
]

{ #category : #logging }
EDACLogging classSide >> stdout [
	^ Stdio stdout
]

{ #category : #logging }
EDACLogging >> logDebugMessage: aMessage [
	^ self class logDebugMessage: aMessage
]

{ #category : #logging }
EDACLogging >> logDebugMessage: aMessage beautify: aBoolean [
	^ self class logDebugMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDACLogging >> logErrorMessage: aMessage [
	^ self class logErrorMessage: aMessage
]

{ #category : #logging }
EDACLogging >> logErrorMessage: aMessage andThrow: anExceptionClass [
	^ self class logErrorMessage: aMessage andThrow: anExceptionClass
]

{ #category : #logging }
EDACLogging >> logErrorMessage: aMessage beautify: aBoolean [
	^ self class logErrorMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDACLogging >> logErrorMessage: aMessage beautify: aBoolean andThrow: anExceptionClass [
	^ self class logErrorMessage: aMessage beautify: aBoolean andThrow: anExceptionClass
]

{ #category : #logging }
EDACLogging >> logInfoMessage: aMessage [
	^ self class logInfoMessage: aMessage
]

{ #category : #logging }
EDACLogging >> logInfoMessage: aMessage beautify: aBoolean [
	^ self class logInfoMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDACLogging >> logTraceMessage: aMessage [
	^ self class logTraceMessage: aMessage
]

{ #category : #logging }
EDACLogging >> logTraceMessage: aMessage beautify: aBoolean [
	^ self class logTraceMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDACLogging >> logWarningMessage: aMessage [
	^ self class logWarningMessage: aMessage
]

{ #category : #logging }
EDACLogging >> logWarningMessage: aMessage beautify: aBoolean [
	^ self class logWarningMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDACLogging >> nextPut: aCharacter [
	^ self class nextPut: aCharacter
]

{ #category : #logging }
EDACLogging >> nextPutAll: aString [
	^ self class nextPutAll: aString
]

{ #category : #logging }
EDACLogging >> print: aString [
	^ self class print: aString
]
