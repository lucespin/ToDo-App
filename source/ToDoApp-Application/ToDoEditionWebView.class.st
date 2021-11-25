Class {
	#name : #ToDoEditionWebView,
	#superclass : #WAPainter,
	#instVars : [
		'todoToEdit',
		'acceptButton',
		'toDoWebView'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #'instance creation' }
ToDoEditionWebView class >> editing: aToDoToEdit [

	^ self new initializeEditing: aToDoToEdit
]

{ #category : #initialization }
ToDoEditionWebView >> configureTriggers [

	acceptButton on trigger
		disable;
		serverDo: [ 
			toDoWebView
				withModelDo: [ :anUpdatedToDo | 
					self session applicationContext
						updateToDo: todoToEdit with: anUpdatedToDo;
						setCurrentWebViewTo: ToDosDashboardWebView new
					]
				ifUnable: [ 
				self session applicationContext setCurrentWebViewTo: self class newWhenDescriptionIsEmpty ]
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDoEditionWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier asynchronicButtonLabeled: 'Accept'
		                applying: [ :theButton |  ]
]

{ #category : #initialization }
ToDoEditionWebView >> initializeEditing: aToDoToEdit [

	todoToEdit := aToDoToEdit.
	toDoWebView := ToDoWebView new.

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
