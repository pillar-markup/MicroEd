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
