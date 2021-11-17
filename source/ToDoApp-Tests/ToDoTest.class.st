Class {
	#name : #ToDoTest,
	#superclass : #TestCase,
	#category : #'ToDoApp-Tests'
}

{ #category : #tests }
ToDoTest >> testAssignTo [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo assignTo: 'Dexter'.

	aToDo
		withAssignedEmployeeDo: [ :anEmployee | self assert: anEmployee equals: 'Dexter' ]
		ifNone: [ self fail ]
]

{ #category : #tests }
ToDoTest >> testAssignToAnEmployeeIfToDoIsFinishedShouldFaild [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo
		assignTo: 'Dexter';
		markAsInProgress;
		markAsFinished.

	self
		should: [ aToDo assignTo: 'Debora' ]
		raise: AssertionFailed
		withMessageText: 'A finished ToDo can''t be reassigned'
]

{ #category : #tests }
ToDoTest >> testCreateAToDoWithoutDescriptionShouldFaild [

	self
		should: [ ToDo describedBy: nil ]
		raise: AssertionFailed
		withMessageText: 'A ToDo have a description'
]

{ #category : #tests }
ToDoTest >> testMarkAsFinishedIfToDoIsOpenShouldFail [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo assignTo: 'Dexter'.

	self
		should: [ aToDo markAsFinished. ]
		raise: AssertionFailed
		withMessageText: 'An Open ToDo can''t be finished directy'
]

{ #category : #tests }
ToDoTest >> testMarkAsInProgressIfToDoIsNotAssignedShouldFail [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	self
		should: [ aToDo markAsInProgress ]
		raise: AssertionFailed
		withMessageText: 'An in-progress ToDo must be assigned'
]
