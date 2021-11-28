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

	self assertDescriptionIsNotEmpty: aDescription.

	^ self new initializeDescribedBy: aDescription withStartDate: aDate
]

{ #category : #'instance creation' }
ToDo class >> describedBy: aDescription withStartDate: aStartDate andCompletionDate: aCompletionDate [

	self assertDescriptionIsNotEmpty: aDescription.

	^ self new
		initializeDescribedBy: aDescription
		withStartDate: aStartDate
		andCompletionDate: aCompletionDate
]

{ #category : #'private - asserting' }
ToDo >> assert: aStarDate isOnOrPreviousTo: aCompletionDate ifNotRaise: errorToSignal [

	AssertionChecker
		enforce: [aStarDate isOnOrBefore: aCompletionDate]
		because: 'A completion date must be after the start date'
		raising: errorToSignal
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

	possibleAssignedEmployee := Optional containing: anEmployee 
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
	state := OpenToDo new.
	possibleAssignedEmployee := Optional unusedBecause: 'unassigned'.
	possibleStartDate := Optional unusedBecause: 'unassigned'.
	possibleCompletionDate := Optional unusedBecause: 'unassigned'
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
		withAssignedEmployeeDo: [:employee | aStream nextPutAll: employee name]
		ifNone: [aStream nextPutAll: 'unassigned'].
	aStream nextPutAll: '. Start date: '.
	self withStartDateDo: [:date | date printOn: aStream] ifNone: [aStream nextPutAll: 'unassigned'].
	aStream nextPutAll: '. Completion date: '.
	self
		withCompletionDateDo: [:date | date printOn: aStream]
		ifNone: [aStream nextPutAll: 'unassigned'].
	aStream nextPut: $.
]

{ #category : #setting }
ToDo >> setCompletionDateTo: aDate [

	possibleStartDate
		withContentDo: [:startDate | self assert: startDate isOnOrPreviousTo: aDate ifNotRaise: AssertionFailed].

	possibleCompletionDate := Optional containing: aDate
]

{ #category : #setting }
ToDo >> setStartDateTo: aDate [

	possibleCompletionDate
		withContentDo: [:completionDate | self assert: aDate isOnOrPreviousTo: completionDate ifNotRaise: AssertionFailed].

	possibleStartDate := Optional containing: aDate
]

{ #category : #updating }
ToDo >> synchronizeWith: aToDo [

	description := aToDo description
]

{ #category : #'private - utility' }
ToDo >> with: anAttribute do: aMonadycBlock ifNone: aNoneBlock [

	^ anAttribute withContentDo: aMonadycBlock ifUnused: aNoneBlock
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
