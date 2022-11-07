"
**Class**

I am something that finds and provides icons.

**Responsibilities**

I'm given instructions as of where to look, and provide icons on demand by searching on those folders.
"
Class {
	#name : #EDACIconProvider,
	#superclass : #Object,
	#instVars : [
		'icons',
		'locations'
	],
	#classVars : [
		'DefaultLocations',
		'IconsFolder'
	],
	#category : #'EDAC-Icons'
}

{ #category : #defaults }
EDACIconProvider class >> addDefaultLocation: aFolder [

	aFolder ifNotNil: [ :f | self defaultLocations add: f ]
]

{ #category : #defaults }
EDACIconProvider class >> defaultLocations [

	^ DefaultLocations ifNil: [ 
		  DefaultLocations := OrderedCollection with:
			                      FileSystem workingDirectory / 'resources'
			                      / 'icons' ]
]

{ #category : #initialization }
EDACIconProvider >> addLocation: aFileReference [

	aFileReference ifNotNil: [ :arg | self locations add: arg ]
]

{ #category : #accessing }
EDACIconProvider >> iconNamed: aName [

	^ self iconNamed: aName ifAbsent: [ Smalltalk ui icons iconNamed: aName ifNone: #comments ]
]

{ #category : #accessing }
EDACIconProvider >> iconNamed: aName ifAbsent: aBlock [

    | icon |
    icon := icons at: aName ifAbsent: [ nil ].
    icon ifNil: [ 
        icon := self loadIconNamed: aName.
        icon ifNil: [ ^ aBlock value ].
        icons at: aName put: icon ].

    ^ icon
]

{ #category : #accessing }
EDACIconProvider >> iconNamed: aName orElse: aDefaultName [

    | icon |
    icon := icons at: aName ifAbsent: [ nil ].
    icon ifNil: [ 
        icon := self loadIconNamed: aName.
        icon ifNil: [ ^ Smalltalk ui iconNamed: #smallConfiguration ].
        icons at: aName put: icon ].

    ^ icon
]

{ #category : #accessing }
EDACIconProvider >> icons [

	^ icons
]

{ #category : #accessing }
EDACIconProvider >> icons: anObject [

	icons := anObject
]

{ #category : #initialization }
EDACIconProvider >> initialize [

	super initialize.
	icons := Dictionary new.
	locations := OrderedCollection withAll: self class defaultLocations
]

{ #category : #accessing }
EDACIconProvider >> loadIcon: fileReference [

	fileReference exists ifFalse: [ 
		self error:
			('Icon {1} does not exit' format: { fileReference fullName }) ].

	^ fileReference binaryReadStreamDo: [ :stream | 
		  Form fromBinaryStream: stream ]
]

{ #category : #accessing }
EDACIconProvider >> loadIconNamed: aSymbol [

    self locations do: [ :each | | ref |
        ref := (each / aSymbol) withExtension: 'png'.
        ref exists ifTrue: [ 
            ^ self loadIcon: ref ] ].
    ^ nil
]

{ #category : #accessing }
EDACIconProvider >> locations [

	^ locations
]
