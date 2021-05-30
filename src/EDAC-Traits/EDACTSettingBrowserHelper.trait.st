Trait {
	#name : #EDACTSettingBrowserHelper,
	#category : #'EDAC-Traits'
}

{ #category : #helper }
EDACTSettingBrowserHelper classSide >> refreshSettingBrowsers [
	self currentWorld submorphs
		select: [ :w | w model class = SettingBrowser ]
		thenCollect: [ :w | w delete. SettingBrowser open ]
]

{ #category : #helper }
EDACTSettingBrowserHelper >> refreshSettingBrowsers [
	self class refreshSettingBrowsers
]
