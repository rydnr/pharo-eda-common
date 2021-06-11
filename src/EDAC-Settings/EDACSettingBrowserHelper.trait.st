Trait {
	#name : #EDACSettingBrowserHelper,
	#category : #'EDAC-Settings'
}

{ #category : #helper }
EDACSettingBrowserHelper classSide >> refreshSettingBrowsers [
	self currentWorld submorphs
		select: [ :w | w model class = SettingBrowser ]
		thenCollect: [ :w | w delete. SettingBrowser open ]
]

{ #category : #helper }
EDACSettingBrowserHelper >> refreshSettingBrowsers [
	^ self class refreshSettingBrowsers
]
