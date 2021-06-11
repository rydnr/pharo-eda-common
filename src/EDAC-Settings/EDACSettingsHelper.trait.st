Trait {
	#name : #EDACSettingsHelper,
	#category : #'EDAC-Settings'
}

{ #category : #helpers }
EDACSettingsHelper classSide >> retrieveFlattenedSettingAsDict: entryName using: env [
	"Retrieves the setting found under given name"

	| result |
	result := env ifNil: [ nil ] ifNotNil: [ :e | e at: entryName ifAbsent: [ nil ] ].
	result ifNil: [ ^ Dictionary new ] ifNotNil: [ :r | ^ r ]
]

{ #category : #helpers }
EDACSettingsHelper classSide >> retrieveSettingAsDict: entryName [
	"Retrieves the setting found under given name"
	^ self retrieveSettingAsDict: entryName using: (self duEnvironmentClass)

]

{ #category : #helpers }
EDACSettingsHelper classSide >> retrieveSettingAsDict: entryName using: env [
	"Retrieves the setting found under given name"

	| result |
	(entryName includes: $/)
		ifTrue: [ | tokens parent |
			tokens := '/' split: entryName.
			parent := tokens first.
			result := self retrieveFlattenedSettingAsDict: (tokens allButFirst joinUsing: '/') using: (self retrieveFlattenedSettingAsDict: parent using: env) ]
		ifFalse: [ result := self retrieveFlattenedSettingAsDict: entryName using: env ].
	result ifNil: [ ^ Dictionary new ] ifNotNil: [ :r | ^ r ]
]

{ #category : #helpers }
EDACSettingsHelper >> retrieveFlattenedSettingAsDict: entryName using: env [
	^ self class retrieveFlattenedSettingAsDict: entryName using: env
]

{ #category : #helpers }
EDACSettingsHelper >> retrieveSettingAsDict: entryName [
	^ self class retrieveSettingAsDict: entryName
]

{ #category : #helpers }
EDACSettingsHelper >> retrieveSettingAsDict: entryName using: env [
	^ self class retrieveSettingAsDict: entryName using: env
]
