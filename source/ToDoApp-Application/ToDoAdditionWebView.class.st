Class {
	#name : #ToDoAdditionWebView,
	#superclass : #WAPainter,
	#instVars : [
		'acceptButton',
		'toDoWebView'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #accessing }
ToDoAdditionWebView class >> errorDescriptionFieldCommand [

	^ [:field | 
	field
		setStyleTo: [:style | 
			style
				borderColor: 'red'
			]
	]
]

{ #category : #'instance creation' }
ToDoAdditionWebView class >> new [

	^ self
		  withDescriptionFieldSuggesting: 'Description'
		  applying: [  ] asWebComponentCommand
]

{ #category : #'instance creation' }
ToDoAdditionWebView class >> newWhenDescriptionIsEmpty [

	^ self withDescriptionFieldSuggesting: 'A ToDo must have a description'
		  applying: self errorDescriptionFieldCommand
]

{ #category : #'private - instance creation' }
ToDoAdditionWebView class >> withDescriptionFieldSuggesting: aSuggestion applying: aComponentCommand [

	^ super new
		  initializeWithDescriptionFieldSuggesting: aSuggestion
		  applying: aComponentCommand
]

{ #category : #configuring }
ToDoAdditionWebView >> configureTriggers [

	acceptButton on trigger
		disable;
		serverDo: [ 
			toDoWebView
				withModelDo: [ :aToDo | 
					self session applicationContext
						addToDo: aToDo;
						setCurrentWebViewTo: ToDosDashboardWebView new
					]
				ifUnable: [ 
				self session applicationContext setCurrentWebViewTo: self class newWhenDescriptionIsEmpty ]
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDoAdditionWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier asynchronicButtonLabeled: 'Accept'
		                applying: [ :theButton |  ]
]

{ #category : #initialization }
ToDoAdditionWebView >> initializeWithDescriptionFieldSuggesting: aSuggestion applying: aComponentCommand [

	toDoWebView := ToDoWebView
		               withDescriptionFieldSuggesting: aSuggestion
		               applying: aComponentCommand.

	self
		initializeAcceptButton;
		configureTriggers
]

{ #category : #rendering }
ToDoAdditionWebView >> renderContentOn: aCanvas [

	aCanvas
		render: toDoWebView;
		render: acceptButton
]
