Class {
	#name : #ToDoTest,
	#superclass : #TestCase,
	#category : #'ToDoApp-Tests'
}

{ #category : #tests }
ToDoTest >> testANewToDoIsOpen [

	| release |

	release := ToDo describedBy: 'Release 2.0 version'.

	self assert: release isOpen.

	self deny: release isInProgress.
	self deny: release isFinished
]

{ #category : #tests }
ToDoTest >> testAssignAToDoToAnEmployee [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo assignTo: 'Dexter'.

	aToDo
		withAssignedEmployeeDo: [ :anEmployee | self assert: anEmployee equals: 'Dexter' ]
		ifNone: [ self assert: false ]
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
		withMessageText: 'ToDo not assigned'
]

{ #category : #tests }
ToDoTest >> testWhenAFinishedToDoIsAssignedToAnEmployeeThenShouldFail [

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
ToDoTest >> testWhenDescriptionIsEmptyThenToDoCreationShouldFail [

	self
		should: [ ToDo describedBy: '' ]
		raise: InstanceCreationFailed
		withMessageText: 'A ToDo must have a description.'
]
