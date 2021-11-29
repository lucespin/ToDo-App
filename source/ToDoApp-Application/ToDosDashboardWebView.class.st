Class {
	#name : #ToDosDashboardWebView,
	#superclass : #WAPainter,
	#instVars : [
		'toDosTable',
		'additionButton'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #styling }
ToDosDashboardWebView >> actionsButtonsStyleCommand [

	^ [ :style | 
	  style
		  backgroundColor: '#7724FF';
		  color: #white;
		  fontWeight: #bold
	  ]
]

{ #category : #'accessing - column renderers' }
ToDosDashboardWebView >> actionsColumn [

	^ self addColumnTitled: 'Actions' rendering: [ :aToDo | 
		  self componentSupplier gridBuilder
			  addContent: ( self buttonToEdit: aToDo );
			  addContent: ( self buttonToRemove: aToDo );
			  build
		  ]
]

{ #category : #styling }
ToDosDashboardWebView >> addButtonStyleCommand [

	^ [ :style | 
	  style
		  backgroundColor: '#57FF7A';
		  color: #white;
		  fontWeight: #bold
	  ]
]

{ #category : #adding }
ToDosDashboardWebView >> addColumnTitled: aTitle rendering: aRenderingCommand [

	^ [:column | 
	column
		titled: aTitle applying: [:title | title setStyleTo: self titleStyleCommand ];
		rendering: aRenderingCommand;
		applyingToEachCell: [:cell | 
			cell
				setStyleTo: [:style | 
					style
						padding: 8 px;
						textAlign: #center
					]
			]
	]
]

{ #category : #'accessing - column renderers' }
ToDosDashboardWebView >> assignedEmployeeColumn [

	^ self
		addColumnTitled: 'Assigned To'
		rendering: [:toDo | toDo withAssignedEmployeeDo: [:employee | employee name] ifNone: ['Unassigned']]
]

{ #category : #accessing }
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

{ #category : #accessing }
ToDosDashboardWebView >> buttonToRemove: aToDo [

	| removalButton |

	removalButton := self componentSupplier asynchronicButtonLabeled: 'Remove'
		                applying: [ :button | button setStyleTo: self actionsButtonsStyleCommand ].

	removalButton on trigger
		serverDo: [ self session applicationContext removeToDo: aToDo ];
		render: self session applicationContext identifiedCurrentWebView.

	^ removalButton
]

{ #category : #'accessing - column renderers' }
ToDosDashboardWebView >> completionDateColumn [

	^ self
		addColumnTitled: 'Completion Date'
		rendering: [:toDo | toDo withCompletionDateDo: [:date | date] ifNone: ['Unassigned']]
]

{ #category : #'accessing - column renderers' }
ToDosDashboardWebView >> descriptionColumn [

	^ self addColumnTitled: 'Description' rendering: [:toDo | toDo description]
]

{ #category : #initialization }
ToDosDashboardWebView >> initialize [

	super initialize.

	self
		initializeTableWebView;
		initializeAdditionButton
]

{ #category : #initialization }
ToDosDashboardWebView >> initializeAdditionButton [

	additionButton := self componentSupplier
		                  asynchronicButtonLabeled: 'Add ToDo'
		                  applying: [ :button | 
		                  button setStyleTo: self addButtonStyleCommand ].

	additionButton on trigger
		serverDo: [ 
			self session applicationContext setCurrentWebViewTo:
					ToDoAdditionWebView new ];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDosDashboardWebView >> initializeTableWebView [

	toDosTable := self componentSupplier tableBuilder
		              addColumn: self startDateColumn;
		              addColumn: self descriptionColumn;
		              addColumn: self completionDateColumn;
		              addColumn: self assignedEmployeeColumn;
		              addColumn: self actionsColumn;
		              apply: [ :table | table setStyleTo: [ :style | style width: '100%' ] ];
		              build
]

{ #category : #rendering }
ToDosDashboardWebView >> renderContentOn: aCanvas [

	toDosTable changeContentsTo: self toDos.

	aCanvas
		render: toDosTable;
		render: additionButton
]

{ #category : #'accessing - column renderers' }
ToDosDashboardWebView >> startDateColumn [

	^ self
		addColumnTitled: 'Start Date'
		rendering: [:toDo | toDo withStartDateDo: [:date | date] ifNone: ['Unassigned']]
]

{ #category : #styling }
ToDosDashboardWebView >> titleStyleCommand [

	^ [ :style | 
	  style
		  color: #white;
		  backgroundColor: '#7724FF';
		  textAlign: #center
	  ]
]

{ #category : #accessing }
ToDosDashboardWebView >> toDos [

	^ self session applicationContext toDos
]
