Class {
	#name : #ToDosDashboardWebView,
	#superclass : #WAPainter,
	#instVars : [
		'toDosTable',
		'additionButton'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #initialization }
ToDosDashboardWebView >> buttonToEdit: aToDo [

	| editButton |

	editButton := self componentSupplier asynchronicButtonLabeled: 'Edit'
		              applying: [ :button | button setStyleTo: self actionsButtonsStyleCommand ].

	editButton on trigger
		serverDo: [ 
			self session applicationContext setCurrentWebViewTo: ( ToDoEditionWebView editing: aToDo ) ];
		render: self session applicationContext identifiedCurrentWebView.

	^ editButton
]

{ #category : #initialization }
ToDosDashboardWebView >> editActionColumn [

	^ self addColumnTitled: '' rendering: [ :toDo | self buttonToEdit: toDo ]
]

{ #category : #initialization }
ToDosDashboardWebView >> initialize [

	super initialize.

	self
		initializeTableWebView;
		initializeAdditionButton
]

{ #category : #initialization }
ToDosDashboardWebView >> initializeTableWebView [

	toDosTable := self componentSupplier tableBuilder
		              addColumn: self startDateColumn;
		              addColumn: self descriptionColumn;
		              addColumn: self completionDateColumn;
		              addColumn: self assignedEmployeeColumn;
		              addColumn: self editActionColumn;
		              apply: [ :table | table setStyleTo: [ :style | style width: '100%' ] ];
		              build
]
