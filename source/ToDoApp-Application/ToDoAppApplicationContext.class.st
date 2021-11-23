Class {
	#name : #ToDoAppApplicationContext,
	#superclass : #Object,
	#instVars : [
		'categoriesRepository',
		'currentWebView',
		'mainWebView',
		'employeesRepository'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #accessing }
ToDoAppApplicationContext >> addEmployee: anEmployee [

	^ employeesRepository addEmployee: anEmployee
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

	categoriesRepository := CategoriesRepository new.
	employeesRepository := EmployeesRepository new
]

{ #category : #accessing }
ToDoAppApplicationContext >> mainWebView [

	^ mainWebView
]

{ #category : #accessing }
ToDoAppApplicationContext >> setCurrentWebViewTo: aCurrentWebView [

	currentWebView := aCurrentWebView
]