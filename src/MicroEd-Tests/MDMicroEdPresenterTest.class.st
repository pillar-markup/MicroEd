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
