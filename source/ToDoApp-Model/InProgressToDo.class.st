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


    Implementation Points
"
Class {
	#name : #InProgressToDo,
	#superclass : #ToDoState,
	#category : #'ToDoApp-Model'
}

{ #category : #'instance creation' }
InProgressToDo >> assign: aToDo to: anEmployee [
 
	AssertionFailed signal: 'An in-progress ToDo can''t be reassigned'
]

{ #category : #isFinished }
InProgressToDo >> isFinished [

	^ false
]

{ #category : #boolean }
InProgressToDo >> isInProgress [

	^ true
]

{ #category : #boolean }
InProgressToDo >> isOpen [

	^ false
]

{ #category : #movement }
InProgressToDo >> markAsFinished: aToDo [

	aToDo changeToFinishedWhenIsInProgress
]
