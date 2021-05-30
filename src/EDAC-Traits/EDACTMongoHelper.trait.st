Trait {
	#name : #EDACTMongoHelper,
	#traits : 'EDACTCollectionHelper',
	#classTraits : 'EDACTCollectionHelper classTrait',
	#category : #'EDAC-Traits'
}

{ #category : #persistence }
EDACTMongoHelper >> initBackendRepository [
	| result |
	result := self mongoRepositoryClass
		mongoUrls: (self csvToCollection: self class urls)
		database: self class databaseName
		username: self class username
		password: self class password.
	"result cache: EDAMongoNoCache new."
	result debug: self class debug.
		"self class enableReplication
		ifTrue: [ result enableReplication ]
		ifFalse: [ result disableReplication ]."
	self class enableSingleton
		ifTrue: [ result enableSingleton ]
		ifFalse: [ result disableSingleton ].
	result ensuringCurrentOnSave: self class ensuringCurrentOnSave.
	result
		ensuringCurrentReferencesOnQueries: self class ensuringCurrentReferencesOnQueries.
	result
		ensuringCurrentReferencesOnQueries: self class ensuringCurrentReferencesOnQueries.
	result lazySynchronize: self class lazySynchronize.
"	result wireProtocolEnabled: self class wireProtocolEnabled."
	^ result
]