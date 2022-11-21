Trait {
	#name : #EDACSettingBrowserHelper,
	#category : #'EDAC-Settings'
}

{ #category : #helper }
EDACSettingBrowserHelper classSide >> deleteSettingBrowsers [

	(self currentWorld submorphs select: [ :w | 
		 w model class = SettingBrowser ]) do: [ :w | w delete ]
]

{ #category : #helper }
EDACSettingBrowserHelper classSide >> refreshSettingBrowsers [

	"SettingBrowser refreshAllSettingBrowsers"

	(self currentWorld submorphs select: [ :w | 
		 w model class = SettingBrowser ]) do: [ :w | 
		w delete.
		SettingBrowser open ]
]

{ #category : #helper }
EDACSettingBrowserHelper >> deleteSettingBrowsers [

	^ self class deleteSettingBrowsers
]

{ #category : #helper }
EDACSettingBrowserHelper >> refreshSettingBrowsers [
	^ self class refreshSettingBrowsers
]
