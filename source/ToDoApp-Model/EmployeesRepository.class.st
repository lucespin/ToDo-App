Class {
	#name : #EmployeesRepository,
	#superclass : #Object,
	#instVars : [
		'employees'
	],
	#category : #'ToDoApp-Model'
}

{ #category : #adding }
EmployeesRepository >> addEmployee: anEmployee [

	employees add: anEmployee
]

{ #category : #accessing }
EmployeesRepository >> employees [

	^ employees
]

{ #category : #initialization }
EmployeesRepository >> initialize [

	super initialize.
	employees := OrderedCollection new
]
