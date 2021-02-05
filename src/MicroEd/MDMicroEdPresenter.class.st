"
A little editor for Microdown. 

Todo: 
- menu
- cmd+s should save and render
- when typing at space we can render?
"
Class {
	#name : #MDMicroEdPresenter,
	#superclass : #SpApplicationWithToolbar,
	#instVars : [
		'screen',
		'textInput',
		'textOutput',
		'currentFile',
		'morphWriter',
		'parser',
		'folder',
		'syntaxHelper'
	],
	#category : #MicroEd
}

{ #category : #specs }
MDMicroEdPresenter class >> defaultSpec [
	 ^ SpBoxLayout newTopToBottom
		add: #menu withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #screen withConstraints: [:c | c expand: false];
		add: (SpBoxLayout newLeftToRight
			add: #textInput;
			add: #textOutput;
		yourself);
	yourself
]

{ #category : #'world menu' }
MDMicroEdPresenter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'MicroEd')
		parent: #Tools;
		action: [ self open ];
		order: 40;
		help: 'A microdown Editor & Renderer';
		icon: (self iconNamed: #glamorousBrowseIcon).
	aBuilder withSeparatorAfter
]

{ #category : #examples }
MDMicroEdPresenter class >> open [
	<example>
	^ self new openWithSpec
]

{ #category : #examples }
MDMicroEdPresenter class >> openWithText: anInputText withSyntaxState: aSyntaxState [

	| presenter |
	presenter := self new.
	presenter initializePresentersWithText: anInputText withSyntax: aSyntaxState.
	^ presenter openWithSpec
]

{ #category : #actions }
MDMicroEdPresenter >> cleanAction [
	"CLEAN button is pressed: erase both input and output text content"
	textInput text: ''.
	textOutput text: ''
]

{ #category : #actions }
MDMicroEdPresenter >> configAction [
	"CONFIG button is pressed: open window"
	| selectedDir |
	selectedDir := FDOpenDirectoryDialog new title: 'Select your directory'; openModal.
	selectedDir ifNotNil: [ self folder: selectedDir].
]

{ #category : #accessing }
MDMicroEdPresenter >> currentFile [
	^ currentFile ifNil: [ ^ currentFile := MDEditorNewFile new ]
]

{ #category : #accessing }
MDMicroEdPresenter >> currentFile: aPREditorFile [
	currentFile := aPREditorFile
]

{ #category : #actions }
MDMicroEdPresenter >> exampleAction [
	"GET EXAMPLE button is pressed: fill input text with an example"
	textInput text: syntaxHelper exampleText.
	textOutput text: ''.
]

{ #category : #actions }
MDMicroEdPresenter >> exportAction [
	"EXPORT button is pressed: open export window"
	"check conditions to export"
	self saveAction.
	self currentFile isNew ifTrue: [ ^ self inform: 'Please save your file before export' ].
	self folder ifNil: [self configAction].
	self folder ifNil: [ ^ self inform: 'Please localise your pillar directory in configuration' ].
	(PRExportPresenter withInputFile: self currentFile file withParser: syntaxHelper parser withConfigDirectory: self folder) openWithSpec
	
]

{ #category : #accessing }
MDMicroEdPresenter >> folder [
	^ folder
]

{ #category : #accessing }
MDMicroEdPresenter >> folder: aDirectory [
	folder := aDirectory 
]

{ #category : #initialization }
MDMicroEdPresenter >> initialExtent [
	^ 800@600
]

{ #category : #initialization }
MDMicroEdPresenter >> initializePresenters [
	| initialText  |
	self syntaxState: MDMicroDownSyntax new.
	initialText := '% Type your marked-up text here. Render it and see right the output generated as rich text', String cr, String cr, self syntaxState exampleText.
	self initializePresentersWithText: initialText
]

{ #category : #initialization }
MDMicroEdPresenter >> initializePresentersWithText: anInputText [
	morphWriter := PRRichTextComposer new.

	self menu applyTo: self.
	
	textInput := self newText.
	textInput 
		autoAccept: true; 
		text: anInputText.
	
	textOutput := self newText.
	textOutput text: ''.
	
	self focusOrder add: textInput.
	self focusOrder add: textOutput.

	screen :=  self newLabel.
	self screenLabelWith: syntaxHelper name.
	self focusOrder add: screen.
]

{ #category : #initialization }
MDMicroEdPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: self title;
		initialExtent: self initialExtent;
		windowIcon: (self iconNamed: #glamorousBrowseIcon)
]

{ #category : #api }
MDMicroEdPresenter >> menu [
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
						name: 'Get example';
						description: 'Give a text input example in current syntax';
						icon: (self iconNamed: #smallFindIcon);
						action: [ self exampleAction ] ].
		
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
MDMicroEdPresenter >> microdownParser [ 

	^ MicroDownParser new
]

{ #category : #actions }
MDMicroEdPresenter >> newDocAction [
	"NEW button is pressed: reset tool"
	self cleanAction.
	currentFile := MDEditorNewFile new.
	self updateTitle
]

{ #category : #actions }
MDMicroEdPresenter >> openAction [
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
MDMicroEdPresenter >> renderAction [
	"RENDER button is pressed: render RichText result in output text"
	| document |
	document := syntaxHelper parse: textInput text.
	textOutput text: (morphWriter start: document) 
]

{ #category : #actions }
MDMicroEdPresenter >> saveAction [
	"SAVE button is pressed: save file, then print message if actually saved (if no cancel)"
	self currentFile: (self currentFile save: textInput withExtension: syntaxHelper extension).
	self updateTitle.
	self currentFile isNew ifFalse: [
		self inform: self currentFile fullName, ' is saved'.].
]

{ #category : #api }
MDMicroEdPresenter >> screenLabelWith: aName [
	screen label: 'Your current syntax is: ', aName string
]

{ #category : #accessing }
MDMicroEdPresenter >> syntaxState [
	^ syntaxHelper
]

{ #category : #accessing }
MDMicroEdPresenter >> syntaxState: aSyntaxState [
	syntaxHelper := aSyntaxState.
	parser := aSyntaxState parser.
]

{ #category : #accessing }
MDMicroEdPresenter >> textInputText: aStringOrNil [
	textInput text: aStringOrNil asString
]

{ #category : #accessing }
MDMicroEdPresenter >> title [
	^ 'MicroDown Editor - ', self currentFile basename
]

{ #category : #api }
MDMicroEdPresenter >> updateTitle [
	self window title: self title
]
