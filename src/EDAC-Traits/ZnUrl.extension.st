Extension { #name : #ZnUrl }

{ #category : #'*EDAC-Traits' }
ZnUrl >> decodePercent: arg1 [
	^ ZnResourceMetaUtils decodePercent: arg1 urlEncoded
]
