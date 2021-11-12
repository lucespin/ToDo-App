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


    Implementation Points
"
Class {
	#name : #ToDoAppPresentation,
	#superclass : #WillowApplication,
	#category : #'ToDoApp-Application'
}

{ #category : #accessing }
ToDoAppPresentation class >> applicationTitle [
	
	^ 'ToDo App'
]

{ #category : #accessing }
ToDoAppPresentation class >> handlerName [

	^ 'todo'
]

{ #category : #accessing }
ToDoAppPresentation class >> start [

	(ZnZincServerAdaptor port: 8085) start.
	self registerAsDevelopmentApplication
]

{ #category : #accessing }
ToDoAppPresentation class >> stop [ 

	ZnServer stopDefault.
	ZnZincServerAdaptor allInstancesDo: [ :each | each shutDown ].
	self unregisterFromApplications.
	Smalltalk garbageCollect.
]

{ #category : #accessing }
ToDoAppPresentation >> componentSupplierForApplication [

	^ Bootstrap3ComponentSupplier online
]

{ #category : #accessing }
ToDoAppPresentation >> contentView [

	^ [ :canvas | ]
]

{ #category : #accessing }
ToDoAppPresentation >> jQueryLibrary [

	   ^ JQuery3OnlineLibrary default
]
