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
	toDos:		<Object>


    Implementation Points
"
Class {
	#name : #ToDosRepository,
	#superclass : #Object,
	#instVars : [
		'toDos'
	],
	#category : #'ToDoApp-Model'
}

{ #category : #movement }
ToDosRepository >> addToDo: aToDo [

	toDos add: aToDo
]

{ #category : #initialization }
ToDosRepository >> initialize [

	super initialize.
	toDos := OrderedCollection new
]

{ #category : #movement }
ToDosRepository >> removeToDo: aToDo [

	AssertionChecker enforce: [ aToDo isOpen ] because: 'The ToDo is not open' raising: AssertionFailed.

	toDos remove: aToDo
]

{ #category : #accessing }
ToDosRepository >> toDos [

	^ toDos
]

{ #category : #updating }
ToDosRepository >> updateToDo: aToDo with: anUpdatedToDo [

	toDos
		detect: [ :aStoredToDo | aStoredToDo = aToDo ]
		ifFound: [ :aStoredToDo | aStoredToDo synchronizeWith: anUpdatedToDo ]
		ifNone: [ ObjectNotFound signal: ('No se encontró <1p>.' expandMacrosWith: aToDo) ]
]
