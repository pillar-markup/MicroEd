Class {
	#name : #MDEditorNewFile,
	#superclass : #MDEditorFile,
	#category : #MicroEd
}

{ #category : #accessing }
MDEditorNewFile >> basename [ 
	^ 'newFile'
]

{ #category : #accessing }
MDEditorNewFile >> fullName [
	^ 'New File has no fullname'
]

{ #category : #testing }
MDEditorNewFile >> isNew [
	^ true
]

{ #category : #action }
MDEditorNewFile >> save: aText withExtension: anExtension [
	| selectedFile |
	selectedFile := FDSaveFileDialog new defaultName: ('my_document.', anExtension asString); openModal.
	selectedFile ifNotNil: [ ^ MDEditorOpenedFile new file: selectedFile; save: aText withExtension: anExtension; yourself. ].
	^ self
	
]
