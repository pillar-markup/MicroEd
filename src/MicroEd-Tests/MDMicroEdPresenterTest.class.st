Class {
	#name : #MDMicroEdPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'window'
	],
	#category : #'MicroEd-Tests'
}

{ #category : #running }
MDMicroEdPresenterTest >> tearDown [ 

	window ifNotNil: [ window close ].
	super tearDown.
]

{ #category : #tests }
MDMicroEdPresenterTest >> testCleanAction [
	| presenter |
	self skip.
	presenter := MDMicroEdPresenter new.
	presenter cleanAction.
	self assert: presenter textInputText text equals: ''.
	self assert: presenter textOutputText text equals: ''
]

{ #category : #tests }
MDMicroEdPresenterTest >> testGotCurrentFileWhenIsNotSpecify [
	| presenter |
	presenter := MDMicroEdPresenter new.
	self assert: presenter currentFile class equals: MDEditorNewFile
]

{ #category : #tests }
MDMicroEdPresenterTest >> testGotCurrentFileWhenIsSpecify [
	| presenter |
	presenter := MDMicroEdPresenter new.
	presenter currentFile: MDEditorOpenedFile new.
	self assert: presenter currentFile class equals: MDEditorOpenedFile
]

{ #category : #tests }
MDMicroEdPresenterTest >> testGotFolderWhenIsNotSpecify [
	| presenter |
	presenter := MDMicroEdPresenter new.
	self assert: presenter folder isNil
]

{ #category : #tests }
MDMicroEdPresenterTest >> testGotFolderWhenIsSpecify [
	| presenter directory filesystem |
	filesystem := FileSystem memory.
	presenter := MDMicroEdPresenter new.
	filesystem createDirectory: 'test'.
	directory := filesystem workingDirectory / 'test'.
	presenter folder: directory.
	self assert: presenter folder basenameWithoutExtension equals: 'test'.
]

{ #category : #tests }
MDMicroEdPresenterTest >> testGotMicrodownParser [
	| browser |
	browser := MDMicroEdPresenter new.
	self assert: browser microdownParser class equals: MicroDownParser
]

{ #category : #tests }
MDMicroEdPresenterTest >> testGotSyntaxStateWhenIsNotSpecify [
	| presenter |
	presenter := MDMicroEdPresenter new.
	presenter syntaxState: MDSyntax new.
	self assert: presenter syntaxState class equals: MDSyntax
]

{ #category : #tests }
MDMicroEdPresenterTest >> testGotSyntaxStateWhenIsSpecify [
	| presenter directory filesystem |
	filesystem := FileSystem memory.
	presenter := MDMicroEdPresenter new.
	filesystem createDirectory: 'test'.
	directory := filesystem workingDirectory / 'test'.
	presenter folder: directory.
	self assert: presenter folder basenameWithoutExtension equals: 'test'.
]

{ #category : #'tests-interaction' }
MDMicroEdPresenterTest >> testOpenIsWorkingSmokeTest [

	| browser |
	browser := MDMicroEdPresenter  new.
	window := browser openWithSpec. 
	self tearDown
	

]

{ #category : #tests }
MDMicroEdPresenterTest >> testTextInputTextIsNotSpecify [
	| presenter |
	presenter := MDMicroEdPresenter new.
	self assert: presenter textInputText text equals: '% Type your marked-up text here. Render it and see right the output generated as rich text', String cr, String cr, presenter syntaxState exampleText
]

{ #category : #tests }
MDMicroEdPresenterTest >> testTextInputTextIsSpecify [
	| presenter |
	presenter := MDMicroEdPresenter new.
	presenter textInputText: 'test'.
	self assert: presenter textInputText text equals: 'test'
]
