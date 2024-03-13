Class {
	#name : 'MDEditorPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'window'
	],
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'running' }
MDEditorPresenterTest >> tearDown [ 

	window ifNotNil: [ window close ].
	super tearDown.
]

{ #category : 'tests' }
MDEditorPresenterTest >> testCleanAction [
	| presenter |
	presenter := MDEditorPresenter new.
	presenter cleanInput.
	self assert: presenter textInputText equals: ''.
	self assert: presenter textOutputText equals: ''
]

{ #category : 'tests' }
MDEditorPresenterTest >> testGotCurrentFileWhenIsNotSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	self assert: presenter currentFileState class equals: MDEditorNewFile
]

{ #category : 'tests' }
MDEditorPresenterTest >> testGotCurrentFileWhenIsSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	presenter currentFileState: MDEditorOpenedFile new.
	self assert: presenter currentFileState class equals: MDEditorOpenedFile
]

{ #category : 'tests' }
MDEditorPresenterTest >> testGotMicrodownParser [
	| browser |
	browser := MDEditorPresenter new.
	self assert: browser microdownParser class equals: MicrodownParser
]

{ #category : 'tests' }
MDEditorPresenterTest >> testGotSyntaxStateWhenIsNotSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	presenter syntaxState: MDMicroDownSyntax new.
	self assert: presenter syntaxState class equals: MDMicroDownSyntax
]

{ #category : 'tests-interaction' }
MDEditorPresenterTest >> testOpenIsWorkingSmokeTest [

	| browser |
	browser := MDEditorPresenter  new.
	window := browser open. 
	self tearDown
	

]

{ #category : 'tests' }
MDEditorPresenterTest >> testTextInputTextIsNotSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	self assert: presenter textInputText equals: '% Type your marked-up text here. Render it and see right the output generated as rich text', String cr, String cr, presenter syntaxState exampleText
]

{ #category : 'tests' }
MDEditorPresenterTest >> testTextInputTextIsSpecify [
	| presenter |
	presenter := MDEditorPresenter new.
	presenter textInputText: 'test'.
	self assert: presenter textInputText equals: 'test'
]
