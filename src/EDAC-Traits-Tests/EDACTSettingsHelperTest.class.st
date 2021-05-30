Class {
	#name : #EDACTSettingsHelperTest,
	#superclass : #TestCase,
	#traits : 'EDACTSettingsHelper',
	#classTraits : 'EDACTSettingsHelper classTrait',
	#category : #'EDAC-Traits-Tests'
}

{ #category : #tests }
EDACTSettingsHelperTest >> testFlattenedSettings [
	| actual env |
	env := {('a' -> 'b')} asDictionary.
	actual := self class retrieveSettingAsDict: 'a' using: env.
	self assert: actual equals: 'b'
]

{ #category : #tests }
EDACTSettingsHelperTest >> testFlattenedSettingsWithDictionary [
	| actual env |
	env := {('a' -> 'b').
	('c' -> {('d' -> 'e')} asDictionary)} asDictionary.
	actual := self class retrieveSettingAsDict: 'c' using: env.
	self assert: (actual at: 'd' ifAbsent: nil) equals: 'e'
]

{ #category : #tests }
EDACTSettingsHelperTest >> testNestedSettings [
	| actual env |
	env := {('a' -> 'b').
	('c' -> {('d' -> {('e' -> 'f')} asDictionary)} asDictionary)} asDictionary.
	actual := self class retrieveSettingAsDict: 'c/d' using: env.
	self assert: (actual at: 'e' ifAbsent: nil) equals: 'f'
]
