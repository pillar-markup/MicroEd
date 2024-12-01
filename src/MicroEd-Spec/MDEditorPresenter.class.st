"
A little editor for Microdown. 

Todo: 
- menu
- cmd+s should save and render
- when typing at space we can render?
"
Class {
	#name : 'MDEditorPresenter',
	#superclass : 'SpApplicationWithToolbar',
	#instVars : [
		'textInput',
		'composer',
		'syntaxState',
		'mdFile',
		'renderedText'
	],
	#category : 'MicroEd-Spec',
	#package : 'MicroEd-Spec'
}

{ #category : 'world menu' }
MDEditorPresenter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'MicroEd')
		parent: #Tools;
		action: [ self open ];
		order: 40;
		help: 'A microdown Editor & Renderer';
		icon: (self iconNamed: #glamorousBrowseIcon).
	aBuilder withSeparatorAfter
]

{ #category : 'examples' }
MDEditorPresenter class >> open [
	<example>
	^ self new open
]

{ #category : 'actions' }
MDEditorPresenter >> cleanInput [
	"CLEAN button is pressed: erase both input and output text content"

	textInput text: ''.
	self cleanOutput
]

{ #category : 'actions' }
MDEditorPresenter >> cleanOutput [

	renderedText text: ''
]

{ #category : 'layout' }
MDEditorPresenter >> defaultLayout [

	 ^ SpBoxLayout newTopToBottom
		add: #menu expand: false;
		add: (SpPanedLayout newLeftToRight
			add: textInput;
			add: renderedText;
		yourself);
	yourself
]

{ #category : 'utilities' }
MDEditorPresenter >> exampleText [

	^ '# Header

A figure:
![Pharologo %width=80&caption=Our great figure.](https://files.pharo.org/media/logo/logo.png)

A link: [http://pharo.org](http://pharo.org)

Unordered Lists:
- item 1
  - item 1.1
  - item 1.2
- item 2
- item 3
  - item 3.1

Ordered Lists:
1. sub item 1
3. sub item 2

and nested 

- item 1
  1. sub item 1
  3. sub item 2
- item 2



Horizontal line:
***

Common formats: **Bold**, _italic_, `monospace`

Pharo hyperlinks in code: 
- class `Point`, 
- method `Point class`, `Point>>#setX:setY:`, and 
- package `#’Microdown-Tests’ (for packages).

A codeblock:

```language=Pharo&caption=Beautiful&label=Fig1
   this is a codeblock
```

'
]

{ #category : 'api' }
MDEditorPresenter >> initializeMenuBar [

	menu := self newMenuBar.

	menu
		addGroup: [ :group | 
			group addItem: [ :item | 
					item
						name: 'New';
						description: 'Start in a new file';
						icon: (self iconNamed: #pageIcon);
						action: [ self startNewFile ] ].
			group addItem: [ :item | 
				item
					name: 'Open';
					description: 'Open file';
					shortcut: $o meta;
					icon: (self iconNamed: #openIcon);
					action: [ self openFile ] ].
			group addItem: [ :item | 
				item
					name: 'Save';
					description: 'Save file';
					shortcut: $s meta;
					icon: (self iconNamed: #smallSaveIcon);
					action: [ self saveFile ] ] ];
		addGroup: [ :group | 
			group addItem: [ :item | 
				item
					name: 'Render';
					icon: (self iconNamed: #smallDoItIcon);
					description: 'Render your input text';
					action: [ self renderDocument ] ].

			group addItem: [ :item | 
				item
					name: 'Get example';
					description: 'Give a text input example in current syntax';
					icon: (self iconNamed: #smallFindIcon);
					action: [ self setExampleAsInput ] ] ]
]

{ #category : 'initialization' }
MDEditorPresenter >> initializePresenters [

	| initialText |
	initialText := '% Type your marked-up text here. Render it and see right the output generated as rich text', String cr, String cr, self exampleText.

	self initializePresentersWithText: initialText.
	
	self initializeMenuBar.

]

{ #category : 'initialization' }
MDEditorPresenter >> initializePresentersWithText: anInputText [

	composer := MicRichTextComposer new.

	textInput := self newText.
	textInput text: anInputText.
	textInput
		bindKeyCombination: Character cr asKeyCombination
		toAction: [ :target :morph :event | 
			[ self renderDocument ] schedule.
			event wasHandled: false ].
	"textInput eventHandler whenKeyDownDo: [ :anEvent | 
		[ self application defer: [ self renderAction ] ] schedule.
		anEvent wasHandled: false ]."

	renderedText := self newText
		beNotEditable;
		yourself

]

{ #category : 'initialization' }
MDEditorPresenter >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: self title;
		initialExtent: 800 @ 600;
		windowIcon: (self application iconNamed: #browseIcon)
]

{ #category : 'accessing' }
MDEditorPresenter >> mdFile [

	^ mdFile ifNil: [ mdFile := MDFile new ]
]

{ #category : 'accessing' }
MDEditorPresenter >> mdFile: aMDFile [

	mdFile := aMDFile
]

{ #category : 'actions' }
MDEditorPresenter >> openFile [
	"OPEN button is pressed: open window"

	| selectedFile |
	selectedFile := StOpenFilePresenter new
		                extensions: #( 'md' );
		                openModal.
	selectedFile 
		ifNotNil: [ 
			self mdFile: (MDFile newFromFileReference: selectedFile asFileReference).
			textInput text: selectedFile contents.
			self cleanOutput.
			self updateTitle ]
		ifNil: [ self mdFile: MDFile new ].


]

{ #category : 'actions' }
MDEditorPresenter >> renderDocument [
	"RENDER button is pressed: render input to output text"

	| document |
	document := Microdown parse: textInput text.
	text := composer visit: document.
	renderedText text: text.

]

{ #category : 'actions' }
MDEditorPresenter >> saveFile [
	"SAVE button is pressed: save file, then print message if actually saved (if no cancel)"

	self mdFile save: textInput text asString.
	self window ifNotNil: [ self updateTitle ].

]

{ #category : 'actions' }
MDEditorPresenter >> setExampleAsInput [
	"GET EXAMPLE button is pressed: fill input text with an example"

	textInput text: self exampleText.
	self cleanOutput
]

{ #category : 'actions' }
MDEditorPresenter >> startNewFile [
	"NEW button is pressed: reset tool"

	self cleanInput.
	mdFile := MDFile new.
	self window ifNotNil: [ self updateTitle ] 
]

{ #category : 'accessing' }
MDEditorPresenter >> textInputText [

	^ textInput text
]

{ #category : 'accessing' }
MDEditorPresenter >> textInputText: aString [

	textInput text: aString asString
]

{ #category : 'accessing' }
MDEditorPresenter >> textOutputText [

	^ renderedText text
]

{ #category : 'api' }
MDEditorPresenter >> title [

	^ 'MicroDown Editor - ' , self mdFile basename
]

{ #category : 'api' }
MDEditorPresenter >> updateTitle [

	self window title: self title
]
