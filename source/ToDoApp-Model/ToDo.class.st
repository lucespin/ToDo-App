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
		'state',
		'possibleAssignedEmployee',
		'possibleStartDate',
		'possibleCompletionDate'
	],
	#category : #'ToDoApp-Model'
}

{ #category : #'private - asserting' }
ToDo class >> assertDescriptionIsNotEmpty: aDescription [

	AssertionChecker
		enforce: [ aDescription isNotEmpty ]
		because: 'A ToDo must have a description.'
		raising: InstanceCreationFailed
]

{ #category : #'instance creation' }
ToDo class >> describedBy: aDescription [

	self assertDescriptionIsNotEmpty: aDescription.

	^ self new initializeDescribedBy: aDescription
]

{ #category : #'instance creation' }
ToDo class >> describedBy: aDescription withStartDate: aDate [ 

	^self new initializeDescribedBy: aDescription withStartDate: aDate
]

{ #category : #'Instance creation' }
ToDo class >> describedBy: aDescription withStartDate: aStarDate andCompletionDate: aCompletionDate [

	^ self new
		initializeDescribedBy: aDescription
		withStartDate: aStarDate
		andCompletionDate: aCompletionDate
]

{ #category : #'private - asserting' }
ToDo >> assert: aStarDate isPreviousTo: aCompletionDate [

	AssertionChecker
		enforce: [aStarDate isOnOrBefore: aCompletionDate]
		because: 'A completion date must be after the start date'
		raising: AssertionFailed
]

{ #category : #'private - asserting' }
ToDo >> assertIsAssigned [

	self
		withAssignedEmployeeDo: [ "do nothing.- lespinosa" ]
		ifNone: [ AssertionFailed signal: 'ToDo not assigned' ]
]

{ #category : #movement }
ToDo >> assignTo: anEmployee [

	state assign: self to: anEmployee
]

{ #category : #movement }
ToDo >> assignWhenIsOpen: anEmployee [

	possibleAssignedEmployee := anEmployee 
]

{ #category : #movement }
ToDo >> changeToFinishedWhenIsInProgress [

	state := FinishedToDo new.
]

{ #category : #accessing }
ToDo >> description [

	^ description
]

{ #category : #initialization }
ToDo >> initializeDescribedBy: aDescription [ 

	description := aDescription.
	state := OpenToDo new
]

{ #category : #initialization }
ToDo >> initializeDescribedBy: aDescription withStartDate: aDate [ 

	description := aDescription.
	possibleStartDate := aDate.
	state := OpenToDo new
]

{ #category : #initialization }
ToDo >> initializeDescribedBy: aDescription withStartDate: aStartDate andCompletionDate: aCompletionDate [

	self assert: aStartDate isPreviousTo: aCompletionDate.
	
	description := aDescription.
	possibleStartDate := aStartDate .
	possibleCompletionDate := aCompletionDate.
	state := OpenToDo new
]

{ #category : #boolean }
ToDo >> isFinished [

	^ state isFinished
]

{ #category : #boolean }
ToDo >> isInProgress [

	^ state isInProgress
]

{ #category : #boolean }
ToDo >> isOpen [

	^ state isOpen
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

{ #category : #printing }
ToDo >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' with description: '; 
	nextPutAll: description.
	aStream nextPutAll: '. Assigned employee: '.
	self
		withAssignedEmployeeDo: [:employee | aStream nextPutAll: employee]
		ifNone: [aStream nextPutAll: 'unassigned'].
	aStream nextPutAll: '. Start date: '.
	self withStartDateDo: [:date | date printOn: aStream] ifNone: [aStream nextPutAll: 'unassigned'].
	aStream nextPutAll: '. Completion date: '.
	self
		withCompletionDateDo: [:date | date printOn: aStream]
		ifNone: [aStream nextPutAll: 'unassigned'].
	aStream nextPut: $.
]

{ #category : #'private - utility' }
ToDo >> with: anAttribute do: aMonadycBlock ifNone: aNoneBlock [

	^ anAttribute ifNil: aNoneBlock ifNotNil: aMonadycBlock
]

{ #category : #movement }
ToDo >> withAssignedEmployeeDo: anAssignedEmployeeBlock ifNone: aNoneBlock [

	^ self with: possibleAssignedEmployee do: anAssignedEmployeeBlock ifNone: aNoneBlock
]

{ #category : #movement }
ToDo >> withCompletionDateDo: aMonadycBlock ifNone: aNoneBlock [

	^ self with: possibleCompletionDate do: aMonadycBlock ifNone: aNoneBlock
]

{ #category : #movement }
ToDo >> withStartDateDo: aDateBlock ifNone: aNoneBlock [ 
	
	^ self with: possibleStartDate do: aDateBlock ifNone: aNoneBlock
]
