Class {
	#name : #ToDoAdditionWebView,
	#superclass : #WAPainter,
	#instVars : [
		'acceptButton',
		'toDoWebView'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #'instance creation' }
ToDoAdditionWebView class >> showing: aToDoWebView [

	^ self new initializeShowing: aToDoWebView
]

{ #category : #styling }
ToDoAdditionWebView >> buttonsStyleCommand [

	^ [ :style | 
	  style
		  backgroundColor: '#7724FF';
		  color: #white;
		  fontWeight: #bold
	  ]
]

{ #category : #configuring }
ToDoAdditionWebView >> configureTriggers [

	acceptButton on trigger
		disable;
		serverDo: [ toDoWebView
				withModelDo: [ :aToDo | 
					self session applicationContext
						addToDo: aToDo;
						setCurrentWebViewTo: ToDosDashboardWebView new
					]
				ifUnable: [ self session applicationContext
						setCurrentWebViewTo: (self class showing: ToDoWebView newWhenDescriptionIsEmpty)
					]
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDoAdditionWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier
		asynchronicButtonLabeled: 'Accept'
		applying: [ :theButton | theButton setStyleTo: self buttonsStyleCommand ]
]

{ #category : #initialization }
ToDoAdditionWebView >> initializeShowing: aToDoWebView [

	toDoWebView := aToDoWebView.

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
