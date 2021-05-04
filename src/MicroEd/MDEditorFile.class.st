"
I am an abstract PREditorFile, to distinguish a **new** text file and an existing **opened** text file.
"
Class {
	#name : #MDEditorFile,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#category : #MicroEd
}

{ #category : #accessing }
MDEditorFile >> basename [
	self subclassResponsibility 
]

{ #category : #accessing }
MDEditorFile >> file [
	^ file
]

{ #category : #accessing }
MDEditorFile >> file: aFile [
	file := aFile
]

{ #category : #accessing }
MDEditorFile >> fullName [
	self subclassResponsibility 
]

{ #category : #testing }
MDEditorFile >> isNew [
	self subclassResponsibility 
]

{ #category : #action }
MDEditorFile >> save: aText withExtension: anExtension [
	^ self subclassResponsibility 
]
