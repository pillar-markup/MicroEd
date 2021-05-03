Class {
	#name : #MDMicroEdPresenterTest,
	#superclass : #TestCase,
	#category : #'MicroEd-Tests'
}

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
