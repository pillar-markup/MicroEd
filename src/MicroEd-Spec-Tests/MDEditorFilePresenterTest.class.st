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
	window := presenter open.
	text := 'This is just a test'.
	fileReference := memoryFS / 'aFileReference.md'.
	fileReference writeStreamDo: [
		                 :stream | stream nextPutAll: text ].

	mdFile := MDFile newFromFileReference: fileReference.
]

{ #category : 'running' }
MDEditorFilePresenterTest >> tearDown [ 

	window ifNotNil: [ window close ].
	fileReference ensureDelete.
	super tearDown.
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testCleanAction [

	presenter cleanInput.
	self assert: presenter textInputText equals: ''.
	self assert: presenter textOutputText equals: ''
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

{ #category : 'tests' }
MDEditorFilePresenterTest >> testGotMicrodownParser [
	
	self assert: presenter microdownParser class equals: MicrodownParser
]

{ #category : 'running' }
MDEditorFilePresenterTest >> testMDFileOverwriteFileReferenceWhenAnotherSameFile [

	"We want to test how to overwrite the content of a file when there is another file with the same name. "
	self skip.  
]

{ #category : 'tests-interaction' }
MDEditorFilePresenterTest >> testOpenIsWorkingSmokeTest [

	self assert: window isOpen

]

{ #category : 'running' }
MDEditorFilePresenterTest >> testSaveWithExtension [

	| text textPresenter |
	text := 'This is just a test'.
	textPresenter := self mockTextObject: text.
	presenter textInputText: text. 
	presenter mdFile: mdFile.
	presenter saveFile.

	self assert: mdFile extension equals: 'md'.
	self assert: mdFile contents equals: text.
	
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
