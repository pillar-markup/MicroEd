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
MDSyntax >> exampleText [
	^ '# Header

A figure:
![Pharologo](https://files.pharo.org/media/logo/logo.png|size=80&caption=Our great figure.)

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
	^ (super parse: aText asString) asPillar
]

{ #category : #accessing }
MDSyntax >> parser [
	^ MicroDownParser 
]

{ #category : #accessing }
MDSyntax >> writer [
	^ PRMicrodownWriter
]
