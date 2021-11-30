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
ToDoEditionWebView class >> editing: aToDoToEdit [

	^ self new initializeEditing: aToDoToEdit
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
				ifUnable:
					[ self session applicationContext setCurrentWebViewTo: ToDoWebView newWhenDescriptionIsEmpty ]
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

	toDoToEdit := aToDoToEdit.

	self
		initializeToDoWebView;
		initializeAcceptButton;
		configureTriggers
]

{ #category : #initialization }
ToDoEditionWebView >> initializeToDoWebView [

	toDoWebView := ToDoWebView new.
	toDoWebView updateViewsWith: toDoToEdit
]

{ #category : #rendering }
ToDoEditionWebView >> renderContentOn: aCanvas [

	aCanvas
		render: toDoWebView;
		render: acceptButton
]
