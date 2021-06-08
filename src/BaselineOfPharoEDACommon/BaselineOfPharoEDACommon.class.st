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
			#(#'EDAC-Traits' #'EDAC-Messaging');
		group: 'tests'
			with:
			#(#'EDAC-Traits-Tests');
		group: 'default' with: #('core' 'tests')
]

{ #category : #meta }
BaselineOfPharoEDACommon >> declarePackagesIn: spec [
	spec
		package: #'EDAC-Traits';
		package: #'EDAC-Messaging'
			with: [ spec requires: #('EDAC-Traits') ];
		package: #'EDAC-Traits-Tests'
			with: [ spec requires: #('EDAC-Traits') ]
 
]
