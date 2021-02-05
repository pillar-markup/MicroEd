Class {
	#name : #PRPearNewFile,
	#superclass : #PRPearFile,
	#category : #'MicroEd-Converter'
}

{ #category : #accessing }
PRPearNewFile >> basename [ 
	^ 'newFile'
]

{ #category : #accessing }
PRPearNewFile >> fullName [
	^ 'New File has no fullname'
]

{ #category : #testing }
PRPearNewFile >> isNew [
	^ true
]

{ #category : #action }
PRPearNewFile >> save: aText withExtension: anExtension [
	| selectedFile |
	selectedFile := FDSaveFileDialog new defaultName: ('my_document.', anExtension asString); openModal.
	selectedFile ifNotNil: [ ^ PRPearOpenedFile new file: selectedFile; save: aText withExtension: anExtension; yourself. ].
	^ self
	
]
