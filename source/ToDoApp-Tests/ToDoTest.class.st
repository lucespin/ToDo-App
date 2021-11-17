Class {
	#name : #ToDoTest,
	#superclass : #TestCase,
	#instVars : [
		'writePrologue'
	],
	#category : #'ToDoApp-Tests'
}

{ #category : #running }
ToDoTest >> setUp [

	writePrologue := ToDo describedBy: 'Write the prologue of Funes, el memorioso.'
]

{ #category : #tests }
ToDoTest >> testANewToDoIsOpen [

	| release |

	release := ToDo describedBy: 'Release 2.0 version'.

	self assert: release isOpen.

	self deny: release isInProgress.
	self deny: release isFinished
]

{ #category : #tests }
ToDoTest >> testAssignAnOpenToDoToAnEmployee [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo assignTo: 'Dexter'.

	aToDo
		withAssignedEmployeeDo: [ :anEmployee | self assert: anEmployee equals: 'Dexter' ]
		ifNone: [ self assert: false ]
]

{ #category : #tests }
ToDoTest >> testAssingToAnEmployeeAFinishedToDoShouldFail [

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
ToDoTest >> testAssingToAnEmployeeAnInProgressToDoShouldFail [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo
		assignTo: 'Dexter';
		markAsInProgress.

	self
		should: [ aToDo assignTo: 'Debora' ]
		raise: AssertionFailed
		withMessageText: 'An in-progress ToDo can''t be reassigned'
]

{ #category : #tests }
ToDoTest >> testMarkAsFinishedAnOpenToDoShouldFail [

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
		withMessageText: 'ToDo not assigned'
]

{ #category : #tests }
ToDoTest >> testWhenDescriptionIsEmptyThenToDoCreationShouldFail [

	self
		should: [ ToDo describedBy: '' ]
		raise: InstanceCreationFailed
		withMessageText: 'A ToDo must have a description.'
]

{ #category : #tests }
ToDoTest >> testWhenMarkAsFinishedAnInProgressToDoThenIsFinished [

	writePrologue
		assignTo: 'Jorge Luis Borges';
		markAsInProgress;
		markAsFinished.

	self assert: writePrologue isFinished.

	self deny: writePrologue isOpen.
	self deny: writePrologue isInProgress
]

{ #category : #tests }
ToDoTest >> testWhenMarkAsInProgressAnAssignedOpenToDoThenIsInProgress [

	| donate |

	donate := ToDo describedBy: 'Donate to the cause of Santi Maratea'.
	donate
		assignTo: 'Aye';
		markAsInProgress.

	self assert: donate isInProgress.

	self deny: donate isOpen.
	self deny: donate isFinished
]

{ #category : #tests }
ToDoTest >> testWhenMarkAsInProgressAnInProgressToDoThenIsInProgress [

	| donate |

	donate := ToDo describedBy: 'Donate to the cause of Santi Maratea'.
	donate
		assignTo: 'Aye';
		markAsInProgress;
		markAsInProgress.

	self assert: donate isInProgress.

	self deny: donate isOpen.
	self deny: donate isFinished
]
