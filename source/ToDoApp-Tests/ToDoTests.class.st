Class {
	#name : #ToDoTests,
	#superclass : #TestCase,
	#category : #'ToDoApp-Tests'
}

{ #category : #tests }
ToDoTests >> testAssignTo [
	
	| aToDo |
	
	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.
	
	aToDo assignTo: 'Dexter'.
	
	self assert: aToDo assignedEmployee equals: 'Dexter'
]

{ #category : #tests }
ToDoTests >> testAssignToAnEmployeeIfToDoIsFinishedShouldFaild [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo assignTo: 'Dexter'.
	aToDo markAsInProgress.
	aToDo markAsFinished.

	self
		should: [ aToDo assignTo: 'Debora' ]
		raise: AssertionFailed
		description: 'A finished ToDo can''t be reassigned'
]

{ #category : #tests }
ToDoTests >> testCreateAToDoWithoutDescriptionShouldFaild [
	self
		should: [ ToDo describedBy: nil ]
		raise: AssertionFailed
		description: 'A ToDo have a description'
]

{ #category : #tests }
ToDoTests >> testMarkAsFinishedIfToDoIsOpenShouldFail [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo assignTo: 'Dexter'.

	self
		should: [ aToDo markAsFinished. ]
		raise: AssertionFailed
		description: 'An Open ToDo can''t be finished directy'
]

{ #category : #tests }
ToDoTests >> testMarkAsInProgressIfToDoIsNotAssignedShouldFail [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	self
		should: [ aToDo markAsInProgress ]
		raise: AssertionFailed
		description: 'An in-progress ToDo must be assigned'
]
