Class {
	#name : #ToDoEditionWebView,
	#superclass : #WAPainter,
	#instVars : [
		'acceptButton',
		'toDoWebView',
		'toDoToEdit'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #'instance creation' }
ToDoEditionWebView class >> editing: aToDoToEdit renderedOn: aToDoWebView [

	^ self new initializeEditing: aToDoToEdit renderedOn: aToDoWebView
]

{ #category : #initialization }
ToDoEditionWebView >> configureTriggers [

	acceptButton on trigger
		disable;
		serverDo: [ toDoWebView
				withModelDo: [ :anUpdatedToDo | 
					self session applicationContext
						updateToDo: toDoToEdit with: anUpdatedToDo;
						setCurrentWebViewTo: ToDosDashboardWebView new
					]
				ifUnable: [ self session applicationContext
						setCurrentWebViewTo: (self class editing: toDoToEdit renderedOn: ToDoWebView newWhenDescriptionIsEmpty)
					]
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDoEditionWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier asynchronicButtonLabeled: 'Accept'
		                applying: [ :theButton |  ]
]

{ #category : #initialization }
ToDoEditionWebView >> initializeEditing: aToDoToEdit renderedOn: aToDoWebView [

	toDoToEdit := aToDoToEdit.
	
	toDoWebView := aToDoWebView.
	toDoWebView updateViewsWith: toDoToEdit.

	self
		initializeAcceptButton;
		configureTriggers
]

{ #category : #rendering }
ToDoEditionWebView >> renderContentOn: aCanvas [

	aCanvas
		render: toDoWebView;
		render: acceptButton
]
