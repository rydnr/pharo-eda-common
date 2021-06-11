Class {
	#name : #BaselineOfPharoEDACommon,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoEDACommon
}

{ #category : #baselines }
BaselineOfPharoEDACommon >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			self declarePackagesIn: spec.
			self declareGroupsIn: spec ]
]

{ #category : #meta }
BaselineOfPharoEDACommon >> declareGroupsIn: spec [
	spec
		group: 'core'
			with:
			#(#'EDAC-Fuel' #'EDAC-Traits'  #'EDAC-Logging' #'EDAC-Messaging' #'EDAC-Settings');
		group: 'tests' with: #(#'EDAC-Traits-Tests' #'EDAC-Settings-Tests');
		group: 'default' with: #('core' 'tests')
]

{ #category : #meta }
BaselineOfPharoEDACommon >> declarePackagesIn: spec [
	spec
		package: #'EDAC-Fuel';
		package: #'EDAC-Traits' with: [ spec requires: #('EDAC-Fuel') ];
		package: #'EDAC-Traits-Tests'
			with: [ spec requires: #('EDAC-Traits') ];
		package: #'EDAC-Logging' with: [ spec requires: #('EDAC-Traits') ];
		package: #'EDAC-Messaging'
			with: [ spec requires: #('EDAC-Traits') ];
		package: #'EDAC-Settings';
		package: #'EDAC-Settings-Tests'
			with: [ spec requires: #('EDAC-Settings') ]
]
