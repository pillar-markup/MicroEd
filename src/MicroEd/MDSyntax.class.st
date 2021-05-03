"
I'm just a little helper to support uniformly Microdown and Pillar 
- sample,
- file extension,
- writer,
- parser
I'm used by the editor and the converter. 
"
Class {
	#name : #MDSyntax,
	#superclass : #Object,
	#category : #MicroEd
}

{ #category : #accessing }
MDSyntax >> extension [
	^ 'microdown'
]

{ #category : #accessing }
MDSyntax >> name [
	^ 'MicroDown'
]

{ #category : #accessing }
MDSyntax >> next [
	^ MDPillarState new
]

{ #category : #parsing }
MDSyntax >> parse: aText [
	^ self parser new parse: aText asString
]

{ #category : #accessing }
MDSyntax >> parser [
	^ MicroDownParser 
]

{ #category : #accessing }
MDSyntax >> writer [
	^ PRMicrodownWriter
]
