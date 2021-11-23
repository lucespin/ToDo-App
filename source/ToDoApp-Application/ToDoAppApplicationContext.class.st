"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	categoriesRepository:		<Object>
	currentWebView:		<Object>
	employeesRepository:		<Object>
	mainWebView:		<Object>


    Implementation Points
"
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
