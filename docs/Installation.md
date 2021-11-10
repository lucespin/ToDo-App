# Installation

## Basic Installation

You can load **ToDo-App** evaluating:

```smalltalk
Metacello new
  baseline: 'ToDoApp';
  repository: 'github://lucespin/ToDo-App:release-candidate';
  load.
```

> Change `release-candidate` to some released version if you want a pinned version

## Using as dependency

In order to include **ToDo-App** as part of your project, you should
reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

  spec
    baseline: 'ToDoApp'
      with: [ spec
        repository: 'github://lucespin/ToDo-App:v{XX}'];
    project: 'ToDoApp-Deployment'
      copyFrom: 'ToDoApp'
      with: [ spec loads: 'Deployment' ].
```

> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

  <baseline>
  spec
    for: #common
    do: [ self setUpDependencies: spec.
      spec package: 'My-Package'
        with: [ spec requires: #('ToDoApp-Deployment') ] ]
```

## Provided groups

- `Deployment` will load all the packages needed in a deployed application
- `Tests` will load the test cases
- `Dependent-SUnit-Extensions` will load the extensions to the SUnit framework
- `Tools` will load the extensions to the SUnit framework and development tools
  (inspector and spotter extensions)
- `CI` is the group loaded in the continuous integration setup
- `Development` will load all the needed packages to develop and contribute to
  the project
