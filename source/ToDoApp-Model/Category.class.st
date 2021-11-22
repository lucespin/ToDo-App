"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	name:		<Object>


    Implementation Points
"
Class {
	#name : #Category,
	#superclass : #Object,
	#instVars : [
		'name',
		'toDos'
	],
	#category : #'ToDoApp-Model'
}

{ #category : #'as yet unclassified' }
Category class >> named: aName [

	^ Category new initializeNamed: aName
]

{ #category : #movement }
Category >> categorize: aToDo [ 

	toDos add: aToDo
]

{ #category : #initialization }
Category >> initializeNamed: aName [
	
	name := aName.	
	toDos := OrderedCollection new
]

{ #category : #boolean }
Category >> isCategorizing: aToDo [

	^ toDos includes: aToDo
]

{ #category : #accesing }
Category >> name [

	^ name
]

{ #category : #movement }
Category >> removeCategoryTo: aToDo [ 
	
	toDos remove: aToDo
]
