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
	assignedEmployee:		<Object>
	description:		<Object>
	state:		<Object>


    Implementation Points
"
Class {
	#name : #ToDo,
	#superclass : #Object,
	#instVars : [
		'description',
		'assignedEmployee',
		'state'
	],
	#category : #'ToDoApp-Model'
}

{ #category : #assertions }
ToDo class >> assertDescriptionNotNull: aDescription [

	aDescription ifNil: [ AssertionFailed signal: 'A ToDo have a description' ]
]

{ #category : #'instance creation' }
ToDo class >> describedBy: aDescription [

	self assertDescriptionNotNull: aDescription.

	^ self new describedBy: aDescription
]

{ #category : #movement }
ToDo class >> markAsFinishedWhenIsInProgress [
	self shouldBeImplemented.
]

{ #category : #assertions }
ToDo >> assertIsAssigned [

	assignedEmployee ifNil: [ AssertionFailed signal: 'An in-progress ToDo must be assigned' ]
]

{ #category : #movement }
ToDo >> assignTo: anEmployee [

	state assign: self to: anEmployee
]

{ #category : #movement }
ToDo >> assignWhenIsOpen: anEmployee [

	assignedEmployee := anEmployee 
]

{ #category : #accessing }
ToDo >> assignedEmployee [

	^ assignedEmployee
]

{ #category : #movement }
ToDo >> changeToFinishedWhenIsInProgress [

	state := FinishedToDo new.
]

{ #category : #initialization }
ToDo >> describedBy: aDescription [ 

	description := aDescription.
	state := OpenToDo new
]

{ #category : #movement }
ToDo >> markAsFinished [

	state markAsFinished: self.
]

{ #category : #movement }
ToDo >> markAsInProgress [

	self assertIsAssigned.
	
	state := InProgressToDo new.
]
