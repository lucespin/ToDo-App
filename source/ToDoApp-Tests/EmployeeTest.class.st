"
An EmployeeTest is a test class for testing the behavior of Employee
"
Class {
	#name : #EmployeeTest,
	#superclass : #TestCase,
	#category : #'ToDoApp-Tests'
}

{ #category : #tests }
EmployeeTest >> test01EmployeeMustHaveName [

	self should: [ Employee named: '' ]
		raise: InstanceCreationFailed
		withMessageText: 'Un empleado debe tener un nombre'
]

{ #category : #tests }
EmployeeTest >> test02EmployeeInstanceCreationAndAccessing [

	| name employee |

	name := 'Lucas'.
	employee := Employee named: name.

	self assert: employee name equals: name
]
