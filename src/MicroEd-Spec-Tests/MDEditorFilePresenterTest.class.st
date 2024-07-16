Class {
	#name : 'MDEditorFilePresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'window'
	],
	#category : 'MicroEd-Spec-Tests',
	#package : 'MicroEd-Spec-Tests'
}

{ #category : 'running' }
MDEditorFilePresenterTest >> tearDown [ 

	window ifNotNil: [ window close ].
	super tearDown.
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testCleanAction [
	| presenter |
	presenter := MDEditorPresenter new.
	presenter cleanInput.
	self assert: presenter textInputText equals: ''.
	self assert: presenter textOutputText equals: ''
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testGotCurrentFileWhenIsNotSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	self assert: presenter currentFileState class equals: MDEditorNewFile
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testGotCurrentFileWhenIsSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	presenter currentFileState: MDEditorOpenedFile new.
	self assert: presenter currentFileState class equals: MDEditorOpenedFile
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testGotMicrodownParser [
	| browser |
	browser := MDEditorPresenter new.
	self assert: browser microdownParser class equals: MicrodownParser
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testGotSyntaxStateWhenIsNotSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	presenter syntaxState: MDMicroDownSyntax new.
	self assert: presenter syntaxState class equals: MDMicroDownSyntax
]

{ #category : 'tests-interaction' }
MDEditorFilePresenterTest >> testOpenIsWorkingSmokeTest [

	| browser |
	browser := MDEditorPresenter  new.
	window := browser open. 
	self tearDown
	

]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testTextInputTextIsNotSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	self assert: presenter textInputText equals: '% Type your marked-up text here. Render it and see right the output generated as rich text', String cr, String cr, presenter syntaxState exampleText
]

{ #category : 'tests' }
MDEditorFilePresenterTest >> testTextInputTextIsSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	presenter textInputText: 'test'.
	self assert: presenter textInputText equals: 'test'
]
