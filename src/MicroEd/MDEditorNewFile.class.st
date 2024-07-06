"
I am an editor ""potential"" file, i.e. a file that actually still wasn't written to filesystem. 
"
Class {
	#name : 'MDEditorNewFile',
	#superclass : 'MDEditorFile',
	#category : 'MicroEd',
	#package : 'MicroEd'
}

{ #category : 'accessing' }
MDEditorNewFile >> basename [

	^ 'newFile'
]

{ #category : 'accessing' }
MDEditorNewFile >> fullName [

	^ 'New File has no fullname'
]

{ #category : 'testing' }
MDEditorNewFile >> isNew [

	^ true
]
