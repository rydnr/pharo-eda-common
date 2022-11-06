"
**Class**

I'm a baseline to load PharoEDA Common.

**Responsibilities**

Guide Metacello to load PharoEDA-Common with its dependencies.

**Collaborators**

Metacello
"
Class {
	#name : #BaselineOfPharoEDACommon,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoEDACommon
}

{ #category : #baselines }
BaselineOfPharoEDACommon >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec blessing: #baseline.
		spec postLoadDoIt: #postload:package:.
		self declarePackagesIn: spec.
		self declareGroupsIn: spec ]
]

{ #category : #meta }
BaselineOfPharoEDACommon >> declareGroupsIn: spec [

	spec
		group: 'core'
		with:
			#( #'EDAC-Fuel' #'EDAC-Logging' #'EDAC-Traits' #'EDAC-Messaging'
			   #'EDAC-Settings' #'EDAC-Localization');
		group: 'tests'
		with: #( #'EDAC-Traits-Tests' #'EDAC-Settings-Tests' );
		group: 'default' with: #( 'core' 'tests' )
]

{ #category : #meta }
BaselineOfPharoEDACommon >> declarePackagesIn: spec [

	spec
		package: #'EDAC-Fuel';
		package: #'EDAC-Logging';
		package: #'EDAC-Localization';
		package: #'EDAC-Traits'
		with: [ spec requires: #( 'EDAC-Fuel' 'EDAC-Logging' ) ];
		package: #'EDAC-Traits-Tests'
		with: [ spec requires: #( 'EDAC-Traits' ) ];
		package: #'EDAC-Messaging'
		with: [ spec requires: #( 'EDAC-Traits' ) ];
		package: #'EDAC-Settings';
		package: #'EDAC-Settings-Tests'
		with: [ spec requires: #( 'EDAC-Settings' ) ]
]

{ #category : #hooks }
BaselineOfPharoEDACommon >> postload: loader package: packageSpec [

	| location |
	Locale localeID: 'es'.
	location := (IceRepository registry detect: [ :each | 
		             each name = 'pharo-eda-common' ]) location.
	EDAIconProvider addDefaultLocation: location / 'resources' / 'icons'.
	EDACTranslationProvider addDefaultLocation:
		location / 'resources' / 'l10n'
]
