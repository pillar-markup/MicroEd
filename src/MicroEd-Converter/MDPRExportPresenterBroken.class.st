"
I am the export presenter using file-dialog.
"
Class {
	#name : #MDPRExportPresenterBroken,
	#superclass : #SpPresenter,
	#instVars : [
		'inputFile',
		'syntaxScreen',
		'parser',
		'formatLabel',
		'formatInput',
		'target',
		'directoryScreen',
		'project',
		'configDirectory',
		'confirmButton',
		'cancelButton'
	],
	#category : #'MicroEd-Converter'
}

{ #category : #specs }
MDPRExportPresenterBroken class >> defaultSpec [
	^ SpBoxLayout newVertical 
			add: (SpBoxLayout newHorizontal add: #formatLabel; add: #formatInput) withConstraints: [:c | c height: self toolbarHeight ];
			add: #syntaxScreen withConstraints: [:c | c height: self toolbarHeight ];
			add: #directoryScreen withConstraints: [:c | c height: self toolbarHeight ];
			add: (SpBoxLayout newHorizontal	add: #cancelButton; add: #confirmButton) withConstraints: [:c | c height: self toolbarHeight ];
		yourself.
]

{ #category : #specs }
MDPRExportPresenterBroken class >> open [ 
	<script>
	
	^ self new openWithSpec
]

{ #category : #creation }
MDPRExportPresenterBroken class >> withInputFile: aFileReference withParser: aParser withConfigDirectory: aDirectory [

	^ self basicNew 
		inputFile: aFileReference; 
		parser: aParser; 
		configDirectory: aDirectory; 
		initialize; yourself
]

{ #category : #accessing }
MDPRExportPresenterBroken >> configDirectory [
	^ configDirectory 
]

{ #category : #accessing }
MDPRExportPresenterBroken >> configDirectory: aDirectory [
	configDirectory := aDirectory
]

{ #category : #initialization }
MDPRExportPresenterBroken >> connectPresenters [
	
	cancelButton action: [ self delete ].
	
	confirmButton action: [ 
		self target: formatInput selectedItem.
		self exportAction. 
		self delete ].
	

]

{ #category : #deleting }
MDPRExportPresenterBroken >> deleteBookArchetypeDataIn: aDirectory [
	(aDirectory / 'Chapters') exists ifTrue: [ (aDirectory / 'Chapters') deleteAll ] .
	(aDirectory / '_support') exists ifTrue: [ (aDirectory / '_support') deleteAll ] .
	(aDirectory / 'index.pillar') exists ifTrue: [ (aDirectory / 'index.pillar') delete ] .
	(aDirectory / 'pillar.conf') exists ifTrue: [ (aDirectory / 'pillar.conf') delete ] .
]

{ #category : #actions }
MDPRExportPresenterBroken >> exportAction [
	| inputFileDirectory |
	inputFileDirectory := self inputFile parent.
	"here: it's hardcoded for book archetype. It's a first version. We need to change it if we generalize to other archetypes/templates."
	self deleteBookArchetypeDataIn: inputFileDirectory.
	self project installArchetypeNamed: 'book' fromDirectory: (self configDirectory / 'archetypes' / 'book') asFileReference.	
	self target buildOnly: self inputFile asArray ; buildOn: self project.
	"remove temp data from archetypes/book"
	self deleteBookArchetypeDataIn: inputFileDirectory.
	self inform: self inputFile basename, 'is exported!'
]

{ #category : #list }
MDPRExportPresenterBroken >> formatList [
	^ PRWritingTarget subclasses collect: [ :class | class new ]
]

{ #category : #initialization }
MDPRExportPresenterBroken >> initialExtent [
	^ 600@200
]

{ #category : #initialization }
MDPRExportPresenterBroken >> initializePresenters [
	
	formatLabel := self newLabel label: 'Export format:'.
	formatInput := SpDropListPresenter new
		items: self formatList;
		display: [ :item | item extension asString ].
	
	syntaxScreen := self newLabel label: 'Input syntax: BLA' ", self parser name".
	directoryScreen := self newLabel label: 'Final export directory: Blop' ", self inputFile fullName", '\_result'.
	
	cancelButton := self newButton label: 'Cancel'.
	confirmButton := self newButton label: 'Export'.
	
	self focusOrder 
		add: formatLabel; add: formatInput;
		add: syntaxScreen; add: directoryScreen;
		add: cancelButton; add: confirmButton
]

{ #category : #initialization }
MDPRExportPresenterBroken >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Export';
		initialExtent: self initialExtent
]

{ #category : #accessing }
MDPRExportPresenterBroken >> inputFile [
	"required at creation"
	^inputFile
]

{ #category : #accessing }
MDPRExportPresenterBroken >> inputFile: aFile [
	inputFile := aFile
]

{ #category : #accessing }
MDPRExportPresenterBroken >> parser [
	"Pay attention this is a hack to make sure that the converter is working. 
	Obviously a pillar to microdown parser has to have a dependency to pillar!
	and so far the microEd project is just for editing microdown. 
	The package MicroEd-Converter should be moved to Pillar!!!!"
	
	^ parser ifNil: [ parser := PRPillarParser new. parser ]
]

{ #category : #accessing }
MDPRExportPresenterBroken >> parser: aParser [
	parser := aParser
]

{ #category : #accessing }
MDPRExportPresenterBroken >> project [
	^ project ifNil: [ ^ PRProject on: self inputFile parent ]
]

{ #category : #accessing }
MDPRExportPresenterBroken >> project: aPRProject [
	project := aPRProject 
]

{ #category : #accessing }
MDPRExportPresenterBroken >> target [
	^ target
]

{ #category : #accessing }
MDPRExportPresenterBroken >> target: aWritingTarget [
	target := aWritingTarget 
]
