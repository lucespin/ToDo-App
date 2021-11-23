Class {
	#name : #WelcomeWebView,
	#superclass : #WAPainter,
	#category : #'ToDoApp-Application'
}

{ #category : #rendering }
WelcomeWebView >> renderContentOn: aCanvas [

	aCanvas render: ( HeadingWebView displaying: 'Welcome' withLevel: 2 )
]
