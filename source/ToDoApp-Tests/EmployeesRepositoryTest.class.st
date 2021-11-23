Class {
	#name : #EmployeesRepositoryTest,
	#superclass : #TestCase,
	#category : #'ToDoApp-Tests'
}

{ #category : #tests }
EmployeesRepositoryTest >> test01EmployeesRepositoryStartEmpty [

	self assertEmpty: EmployeesRepository new employees
]

{ #category : #tests }
EmployeesRepositoryTest >> test02AddingEmployee [

	| employeesRepository employee |

	employeesRepository := EmployeesRepository new.

	self assertEmpty: employeesRepository employees.

	employee := Employee named: 'Lucas'.

	employeesRepository addEmployee: employee.

	self withTheOnlyOneIn: employeesRepository employees
		do: [ :storedEmployee | self assert: storedEmployee equals: employee ]
]
