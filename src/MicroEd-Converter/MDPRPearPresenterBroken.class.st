"
**Pear** is an editor and RichText renderer for both Pillar and MicroDown syntaxes, developed by Laurine Dargaud (2020). PEAR stands for Pillar Editor And Renderer. It is implemented a Spec2.

Open me executing the following method: `PRPearPresenter class>>#open`

### Features
- **New:** open a new file
- **Open:** open a existing text file from your directories
- **Save:** save your new file or your opened file
- **Clean:** delete text content in your opened file
- **Render:** see the RichText result of your markuped text
- **Get example:** print an example markuped text which covers characteristic grammar
- **Change input syntax:** switch between Pillar or MicroDown markup syntax
- **Convert:** open a new presenter with your input text converted into the other syntax using associate writer

_For now, export feature is unavailable, so it has been removed from menu - but relative classes and methods in code exist_

**Note: **I implemented a **state-like pattern** to switch between syntax Pillar and MicroDown: `PRPearSyntaxState`

## How to add a new feature?

1. Add a button in the Menu bar in `PRPearPresenter>>#menu`
2. Create the action method to launch when your button is pressed (see examples in **actions** protocol, like _saveAction_ or _renderAction_)




"
Class {
	#name : #MDPRPearPresenterBroken,
	#superclass : #SpApplicationWithToolbar,
	#instVars : [
		'syntaxState',
		'screen',
		'textInput',
		'textOutput',
		'currentFile',
		'configPillarFolder',
		'morphWriter',
		'parser'
	],
	#category : #'MicroEd-Converter'
}

{ #category : #specs }
MDPRPearPresenterBroken class >> defaultSpec [
	 ^ SpBoxLayout newVertical
		add: #menu withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #screen withConstraints: [:c | c expand: false];
		add: (SpBoxLayout newHorizontal
			add: #textInput;
			add: #textOutput;
		yourself);
	yourself
]

{ #category : #'world menu' }
MDPRPearPresenterBroken class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Pear')
		parent: #Tools;
		action: [ self open ];
		order: 40;
		help: 'Pillar Editor And Renderer';
		icon: (self iconNamed: #glamorousBrowseIcon).
	aBuilder withSeparatorAfter
]

{ #category : #examples }
MDPRPearPresenterBroken class >> open [
	<example>
	^ self new openWithSpec
]

{ #category : #examples }
MDPRPearPresenterBroken class >> openWithText: anInputText withSyntaxState: aSyntaxState [
	| presenter |
	presenter := self new.
	presenter initializePresentersWithText: anInputText withSyntax: aSyntaxState.
	^ presenter openWithSpec
]

{ #category : #actions }
MDPRPearPresenterBroken >> changeAction [
	"CHANGE button is pressed: change input syntax with next syntax state"
	syntaxState := syntaxState next.
	parser := syntaxState parser.
	self exampleAction.
	self screenLabelWith: syntaxState name.
	self inform: 'Now, you''re working on ', syntaxState name
]

{ #category : #actions }
MDPRPearPresenterBroken >> cleanAction [
	"CLEAN button is pressed: erase both input and output text content"
	textInput text: ''.
	textOutput text: ''
]

{ #category : #actions }
MDPRPearPresenterBroken >> configAction [
	"CONFIG button is pressed: open window"
	| selectedDir |
	selectedDir := FDOpenDirectoryDialog new defaultName: 'pillar'; title: 'Select pillar directory in your installation'; openModal.
	selectedDir ifNotNil: [ self configPillarFolder: selectedDir].
]

{ #category : #accessing }
MDPRPearPresenterBroken >> configPillarFolder [
	^ configPillarFolder
]

{ #category : #accessing }
MDPRPearPresenterBroken >> configPillarFolder: aDirectory [
	configPillarFolder := aDirectory 
]

{ #category : #actions }
MDPRPearPresenterBroken >> convertAction [
	| convertedInput |
	convertedInput := syntaxState write: textInput text.
	self class openWithText: convertedInput withSyntaxState: syntaxState next.
	self inform: 'A new Editor appears, set on ', syntaxState next name
]

{ #category : #accessing }
MDPRPearPresenterBroken >> currentFile [
	^ currentFile ifNil: [ ^ currentFile := MDEditorNewFile new ]
]

{ #category : #accessing }
MDPRPearPresenterBroken >> currentFile: aPREditorFile [
	currentFile := aPREditorFile
]

{ #category : #actions }
MDPRPearPresenterBroken >> exampleAction [
	"GET EXAMPLE button is pressed: fill input text with an example"
	textInput text: syntaxState exampleText.
	textOutput text: ''.
]

{ #category : #actions }
MDPRPearPresenterBroken >> exportAction [
	"EXPORT button is pressed: open export window"
	"check conditions to export"
	self saveAction.
	self currentFile isNew ifTrue: [ ^ self inform: 'Please save your file before export' ].
	self configPillarFolder ifNil: [self configAction].
	self configPillarFolder ifNil: [ ^ self inform: 'Please localise your pillar directory in configuration' ].
	(MDPRExportPresenterBroken withInputFile: self currentFile file withParser: syntaxState parser withConfigDirectory: self configPillarFolder) openWithSpec
	
]

{ #category : #initialization }
MDPRPearPresenterBroken >> initialExtent [
	^ 800@600
]

{ #category : #initialization }
MDPRPearPresenterBroken >> initializePresenters [
	| initialText initialSyntaxState |
	initialSyntaxState := MDPillarState new.
	initialText := '% Type your marked-up text here. Render it and see right the output generated as rich text', String cr, String cr, initialSyntaxState exampleText.
	self initializePresentersWithText: initialText withSyntax: initialSyntaxState
]

{ #category : #initialization }
MDPRPearPresenterBroken >> initializePresentersWithText: anInputText withSyntax: aSyntaxState [
	morphWriter := PRRichTextComposer new.
	syntaxState := aSyntaxState.
	parser := syntaxState parser.

	self menu applyTo: self.
	
	textInput := self newText.
	textInput text: anInputText.
	
	textOutput := self newText.
	textOutput text: ''.
	
	self focusOrder add: textInput.
	self focusOrder add: textOutput.

	screen :=  self newLabel.
	self screenLabelWith: syntaxState name.
	self focusOrder add: screen.
]

{ #category : #initialization }
MDPRPearPresenterBroken >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: self title;
		initialExtent: self initialExtent;
		windowIcon: (self iconNamed: #glamorousBrowseIcon)
]

{ #category : #api }
MDPRPearPresenterBroken >> menu [
	^ menu ifNil: [ ^ menu := self newMenuBar
		addGroup: [ :group | 
			group 
				addItem: [ :item | 
					item
						name: 'New';
						description: 'New document';
						icon: (self iconNamed: #pageIcon);
						action: [ self newDocAction ] ].
			group
				addItem: [ :item | 
					item
						name: 'Open';
						description: 'Open file';
						shortcut: $o meta;
						icon: (self iconNamed: #openIcon);
						action: [ self openAction ] ].
			group
				addItem: [ :item | 
					item
						name: 'Save';
						description: 'Save file';
						shortcut: $s meta;
						icon: (self iconNamed: #smallSaveIcon);
						action: [ self saveAction ] ].
			group 
				addItem: [ :item | 
					item
						name: 'Clean';
						description: 'Erase input text';
						icon: (self iconNamed: #smallCancel);
						action: [ self cleanAction ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'Render';
						icon: (self iconNamed: #smallDoItIcon);
						description: 'Render your input text';
						action: [ self renderAction	]
				].
			group
				addItem: [ :item | 
					item
						name: 'Change input syntax';
						description: 'Switch with MicroDown or Pillar';
						icon: (self iconNamed: #changeUpdateIcon);
						action: [ self changeAction ] 
				].
			group
				addItem: [ :item | 
					item
						name: 'Get example';
						description: 'Give a text input example in current syntax';
						icon: (self iconNamed: #smallFindIcon);
						action: [ self exampleAction ] ].
			group
				addItem: [ :item | 
					item
						name: 'Convert';
						description: 'Open a new editor with input text converted in the other syntax';
						icon: (self iconNamed: #glamorousRestartIcon);
						action: [ self convertAction ] 
				]	
		];
	"addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'Export';
						description: 'Build your document in export formt you want';
						icon: (self iconNamed: #glamorousOpenFromUrlIcon);
						action: [ self exportAction ] ].
			group
				addItem: [ :item | 
					item
						name: 'Set config';
						description: 'Give your Pillar installation directory path to be able to export';
						icon: (self iconNamed: #configIcon);
						action: [ self configAction ] ] ];" yourself ]
]

{ #category : #actions }
MDPRPearPresenterBroken >> newDocAction [
	"NEW button is pressed: reset tool"
	self cleanAction.
	currentFile := MDEditorNewFile new.
	self updateTitle
]

{ #category : #actions }
MDPRPearPresenterBroken >> openAction [
	"OPEN button is pressed: open window"
	| openFileDialog |
	openFileDialog := FDOpenFileDialog new whenSelected: [
		:selectedFile |
			self currentFile: (MDEditorOpenedFile new file: selectedFile).
			textInput text: selectedFile contents.
			textOutput text: ''.
			self updateTitle
		].
	openFileDialog openWithSpec 
]

{ #category : #actions }
MDPRPearPresenterBroken >> renderAction [
	"RENDER button is pressed: render RichText result in output text"
	| document |
	document := syntaxState parse: textInput text.
	textOutput text: (morphWriter start: document) 
]

{ #category : #actions }
MDPRPearPresenterBroken >> saveAction [
	"SAVE button is pressed: save file, then print message if actually saved (if no cancel)"
	self currentFile: (self currentFile save: textInput withExtension: syntaxState extension).
	self updateTitle.
	self currentFile isNew ifFalse: [
		self inform: self currentFile fullName, ' is saved'.].
]

{ #category : #api }
MDPRPearPresenterBroken >> screenLabelWith: aName [
	screen label: 'Your current syntax is: ', aName string
]

{ #category : #accessing }
MDPRPearPresenterBroken >> syntaxState [
	^ syntaxState
]

{ #category : #accessing }
MDPRPearPresenterBroken >> syntaxState: aSyntaxState [
	syntaxState := aSyntaxState.
	parser := aSyntaxState parser.
]

{ #category : #accessing }
MDPRPearPresenterBroken >> textInputText: aStringOrNil [
	textInput text: aStringOrNil asString
]

{ #category : #accessing }
MDPRPearPresenterBroken >> title [
	^ 'PEAR - ', self currentFile basename
]

{ #category : #api }
MDPRPearPresenterBroken >> updateTitle [
	self window title: self title.
]
