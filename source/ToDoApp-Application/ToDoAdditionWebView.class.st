Class {
	#name : #ToDoAdditionWebView,
	#superclass : #WAPainter,
	#instVars : [
		'acceptButton',
		'toDoWebView'
	],
	#category : #'ToDoApp-Application'
}

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
				self session applicationContext setCurrentWebViewTo: ToDoWebView newWhenDescriptionIsEmpty ]
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDoAdditionWebView >> initialize [

	toDoWebView := ToDoWebView new.

	self
		initializeAcceptButton;
		configureTriggers
]

{ #category : #initialization }
ToDoAdditionWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier asynchronicButtonLabeled: 'Accept'
		                applying: [ :theButton |  ]
]

{ #category : #rendering }
ToDoAdditionWebView >> renderContentOn: aCanvas [

	aCanvas
		render: toDoWebView;
		render: acceptButton
]
