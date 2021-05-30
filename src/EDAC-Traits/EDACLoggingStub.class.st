"
I'm a stub to provide logging via EDATLogging to target classes we cannot change directly.

I'm expected to be used by extension methods to use EDATLogging.

I rely on EDATLogging to provide logging to target classes.

Example:

To add EDATLogging-based logging to ZnLogEvent class, add an extension method such as
""*EDA-Logging""
logToStdout
	self stopLoggingToTranscript.
	^ self announcer when: ZnLogEvent do: [ :event | EDATLoggingStub new logInfoMessage: event ]
"
Class {
	#name : #EDACLoggingStub,
	#superclass : #Object,
	#traits : 'EDACTLogging',
	#classTraits : 'EDACTLogging classTrait',
	#category : #'EDAC-Traits'
}

{ #category : #logging }
EDACLoggingStub class >> logDebugMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings debugEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'DEBUG'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACLoggingStub class >> logErrorMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings errorEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'ERROR'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACLoggingStub class >> logInfoMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings infoEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'INFO '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACLoggingStub class >> logTraceMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings traceEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'TRACE'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACLoggingStub class >> logWarningMessage: aMessage beautify: aBoolean [
	^ EDACLoggingSettings warningEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'WARN '
				inStream: self defaultStream
				beautify: aBoolean ]
]
