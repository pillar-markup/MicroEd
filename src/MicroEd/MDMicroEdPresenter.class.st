Class {
	#name : #MDMicroEdPresenter,
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
	#category : #MicroEd
}

{ #category : #specs }
MDMicroEdPresenter class >> defaultSpec [
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
MDMicroEdPresenter class >> menuCommandOn: aBuilder [
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
MDMicroEdPresenter >> changeAction [
	"CHANGE button is pressed: change input syntax with next syntax state"
	syntaxState := syntaxState next.
	parser := syntaxState parser.
	self exampleAction.
	self screenLabelWith: syntaxState name.
	self inform: 'Now, you''re working on ', syntaxState name
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
	selectedDir := FDOpenDirectoryDialog new defaultName: 'pillar'; title: 'Select pillar directory in your installation'; openModal.
	selectedDir ifNotNil: [ self configPillarFolder: selectedDir].
]

{ #category : #accessing }
MDMicroEdPresenter >> configPillarFolder [
	^ configPillarFolder
]

{ #category : #accessing }
MDMicroEdPresenter >> configPillarFolder: aDirectory [
	configPillarFolder := aDirectory 
]

{ #category : #actions }
MDMicroEdPresenter >> convertAction [
	| convertedInput |
	convertedInput := syntaxState write: textInput text.
	self class openWithText: convertedInput withSyntaxState: syntaxState next.
	self inform: 'A new Editor appears, set on ', syntaxState next name
]

{ #category : #accessing }
MDMicroEdPresenter >> currentFile [
	^ currentFile ifNil: [ ^ currentFile := PRPearNewFile new ]
]

{ #category : #accessing }
MDMicroEdPresenter >> currentFile: aPREditorFile [
	currentFile := aPREditorFile
]

{ #category : #actions }
MDMicroEdPresenter >> exampleAction [
	"GET EXAMPLE button is pressed: fill input text with an example"
	textInput text: syntaxState exampleText.
	textOutput text: ''.
]

{ #category : #actions }
MDMicroEdPresenter >> exportAction [
	"EXPORT button is pressed: open export window"
	"check conditions to export"
	self saveAction.
	self currentFile isNew ifTrue: [ ^ self inform: 'Please save your file before export' ].
	self configPillarFolder ifNil: [self configAction].
	self configPillarFolder ifNil: [ ^ self inform: 'Please localise your pillar directory in configuration' ].
	(PRExportPresenter withInputFile: self currentFile file withParser: syntaxState parser withConfigDirectory: self configPillarFolder) openWithSpec
	
]

{ #category : #initialization }
MDMicroEdPresenter >> initialExtent [
	^ 800@600
]

{ #category : #initialization }
MDMicroEdPresenter >> initializePresenters [
	| initialText initialSyntaxState |
	initialSyntaxState := PRPearPillarState new.
	initialText := '% Type your marked-up text here. Render it and see right the output generated as rich text', String cr, String cr, initialSyntaxState exampleText.
	self initializePresentersWithText: initialText withSyntax: initialSyntaxState
]

{ #category : #initialization }
MDMicroEdPresenter >> initializePresentersWithText: anInputText withSyntax: aSyntaxState [
	morphWriter := PRRichTextComposer new.
	syntaxState := aSyntaxState.
	parser := syntaxState parser.

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
	self screenLabelWith: syntaxState name.
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
MDMicroEdPresenter >> newDocAction [
	"NEW button is pressed: reset tool"
	self cleanAction.
	currentFile := PRPearNewFile new.
	self updateTitle
]

{ #category : #actions }
MDMicroEdPresenter >> openAction [
	"OPEN button is pressed: open window"
	| openFileDialog |
	openFileDialog := FDOpenFileDialog new whenSelected: [
		:selectedFile |
			self currentFile: (PRPearOpenedFile new file: selectedFile).
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
	document := syntaxState parse: textInput text.
	textOutput text: (morphWriter start: document) 
]

{ #category : #actions }
MDMicroEdPresenter >> saveAction [
	"SAVE button is pressed: save file, then print message if actually saved (if no cancel)"
	self currentFile: (self currentFile save: textInput withExtension: syntaxState extension).
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
	^ syntaxState
]

{ #category : #accessing }
MDMicroEdPresenter >> syntaxState: aSyntaxState [
	syntaxState := aSyntaxState.
	parser := aSyntaxState parser.
]

{ #category : #accessing }
MDMicroEdPresenter >> textInputText: aStringOrNil [
	textInput text: aStringOrNil asString
]

{ #category : #accessing }
MDMicroEdPresenter >> title [
	^ 'PEAR - ', self currentFile basename
]

{ #category : #api }
MDMicroEdPresenter >> updateTitle [
	self window title: self title.
]
