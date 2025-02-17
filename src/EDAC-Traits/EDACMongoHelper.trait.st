Trait {
	#name : #EDACMongoHelper,
	#category : #'EDAC-Traits'
}

{ #category : #helper }
EDACMongoHelper >> csvToCollection: aString [
	^ EDACCollectionHelper csvToCollection: aString
]

{ #category : #persistence }
EDACMongoHelper >> initBackendRepository [

	| result |
	result := self mongoRepositoryClass
		          mongoUrls: (self csvToCollection: self class urls)
		          database: self class database
		          username: self class user
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
	result ensuringCurrentReferencesOnQueries:
		self class ensuringCurrentReferencesOnQueries.
	result ensuringCurrentReferencesOnQueries:
		self class ensuringCurrentReferencesOnQueries.
	result lazySynchronize: self class lazySynchronize.
	"	result wireProtocolEnabled: self class wireProtocolEnabled."
	^ result
]
