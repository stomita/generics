module.exports = ($scope, $routeParams, $location) ->
  console.log $routeParams
  $scope.wizardState = {} unless $scope.wizardState
  $scope.steps = [
    id: "start"
    title: "Welcome"
    isEnabled: -> true
  ,
    id: "connect"
    title: "Establish Connection"
    isEnabled: -> true
  ,
    id: "template"
    title: "Choose Mobile Template"
    isEnabled: ->
      $scope.wizardState.conn
  ,
    id: "datasource"
    title: "Choose Data Source"
    isEnabled: ->
      $scope.wizardState.conn
  ]
  for step, index in $scope.steps when step.id == $routeParams.step
    step.active = true
    $scope.activeStep = step
    $scope.activeStepIndex = index
    break

  $scope.nextStep = ->
    nextStep = $scope.steps[$scope.activeStepIndex+1]
    $location.url("/step/" + nextStep.id) if nextStep


module.exports.$inject = [ "$scope", "$routeParams", "$location" ]