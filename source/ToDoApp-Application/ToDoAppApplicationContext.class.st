Class {
	#name : #ToDoAppApplicationContext,
	#superclass : #Object,
	#instVars : [
		'categoriesRepository',
		'currentWebView',
		'mainWebView',
		'employeesRepository',
		'toDosRepository'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #accessing }
ToDoAppApplicationContext >> addEmployee: anEmployee [

	^ employeesRepository addEmployee: anEmployee
]

{ #category : #accessing }
ToDoAppApplicationContext >> addToDo: aToDo [

	^ toDosRepository addToDo: aToDo
]

{ #category : #accessing }
ToDoAppApplicationContext >> currentWebView [

	^ currentWebView
]

{ #category : #accessing }
ToDoAppApplicationContext >> employees [

	^ employeesRepository employees
]

{ #category : #accessing }
ToDoAppApplicationContext >> identifiedCurrentWebView [

	^ mainWebView identifiedCurrentWebView
]

{ #category : #initialization }
ToDoAppApplicationContext >> initialize [

	super initialize.
	self
		initializeRepositories;
		setCurrentWebViewTo: WelcomeWebView new;
		initializeMainWebView
]

{ #category : #initialization }
ToDoAppApplicationContext >> initializeMainWebView [

	mainWebView := MainWebView new
]

{ #category : #initialization }
ToDoAppApplicationContext >> initializeRepositories [

	toDosRepository := ToDosRepository new.
	categoriesRepository := CategoriesRepository new.
	employeesRepository := EmployeesRepository new
]

{ #category : #accessing }
ToDoAppApplicationContext >> mainWebView [

	^ mainWebView
]

{ #category : #accessing }
ToDoAppApplicationContext >> removeToDo: aToDo [

	^ toDosRepository removeToDo: aToDo
]

{ #category : #accessing }
ToDoAppApplicationContext >> setCurrentWebViewTo: aCurrentWebView [

	currentWebView := aCurrentWebView
]

{ #category : #accessing }
ToDoAppApplicationContext >> toDos [

	^ toDosRepository toDos
]

{ #category : #accessing }
ToDoAppApplicationContext >> updateToDo: aToDo with: anUpdatedToDo [

	^ toDosRepository updateToDo: aToDo with: anUpdatedToDo
]
