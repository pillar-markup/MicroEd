Class {
	#name : 'MDEditorFilePresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'window',
		'memoryFS',
		'presenter',
		'mdFile',
		'fileReference'
	],
	#category : 'MicroEd-Spec-Tests',
	#package : 'MicroEd-Spec-Tests'
}

{ #category : 'running' }
MDEditorFilePresenterTest >> mockTextObject: aString [ 

	^ SpTextPresenter new text: aString 
]

{ #category : 'running' }
MDEditorFilePresenterTest >> setUp [

	| text |
	super setUp.
	memoryFS := FileSystem memory.
	presenter := MDEditorPresenter new.
	
	text := 'This is just a test'.
	fileReference := memoryFS / 'aFileReference.md'.
	fileReference writeStreamDo: [ :stream | stream nextPutAll: text ].

	mdFile := MDFile newFromFileReference: fileReference
]

{ #category : 'running' }
MDEditorFilePresenterTest >> tearDown [

	fileReference ensureDelete.
	super tearDown
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testCleanAction [

	presenter emptyInputText.
	self assert: presenter textInputText equals: ''.
	self assert: presenter renderedText equals: ''
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testGotCurrentFileWhenIsNotSpecify [

	self assert: presenter mdFile class equals: MDFile
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testGotCurrentFileWhenIsSpecify [

	presenter mdFile: mdFile.
	self assert: presenter mdFile class equals: MDFile
]

{ #category : 'running' }
MDEditorFilePresenterTest >> testSaveWithExtension [

	| text textPresenter |
	text := 'This is just a test'.
	textPresenter := self mockTextObject: text.
	presenter textInputText: text.
	presenter mdFile: mdFile.
	mdFile title: 'Dummy title'.
	presenter saveFile.

	self assert: mdFile extension equals: 'md'.
	self assert: mdFile contents equals: text
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testTextInputTextIsNotSpecify [
	
	self assert: presenter textInputText equals: '% Type your marked-up text here. Render it and see right the output generated as rich text', String cr, String cr, presenter exampleText
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testTextInputTextIsSpecify [
	
	presenter textInputText: 'test'.
	self assert: presenter textInputText equals: 'test'
]
