Class {
	#name : #MDPillarSyntax,
	#superclass : #MDEditorSyntax,
	#category : #'MicroEd-Converter'
}

{ #category : #accessing }
MDPillarSyntax >> exampleText [
	^ '! Heading one 

!!Heading Twoo 

""this is bold"". 

This is not bold but this one is ''italic''.

This is a list
- item 1 ""this is bold again my friend"" and without bold here
-- item 11 is nested
-- item 12 is nested too
- item 2
- item 3
-- item 31

This is an ordered collection
# one
# two 

The following code shows the definition of the method ==printOn:==

[[[  
Point class >> new
	self foo	
]]] 

[[[language=smalltalk 
1 + 2 
]]]

! Heading one 

'
]

{ #category : #accessing }
MDPillarSyntax >> extension [
	^ 'pillar'
]

{ #category : #accessing }
MDPillarSyntax >> name [
	^ 'Pillar'
]

{ #category : #accessing }
MDPillarSyntax >> next [
	^ MDMicroDownSyntax new
]

{ #category : #accessing }
MDPillarSyntax >> parser [
	^ PRPillarParser
]

{ #category : #accessing }
MDPillarSyntax >> writer [
	^ PRPillarWriter
]
