module.exports = ($scope, $routeParams, $location) ->
  $scope.steps = [
    id: "start"
    title: "Start"
    isEnabled: -> true
  ,
    id: "template"
    title: "Select Template"
    isEnabled: -> true
  ,
    id: "connect"
    title: "Establish Connection"
    isEnabled: -> true
  ,
    id: "datasource"
    title: "Choose Data Source"
    isEnabled: -> true
  ,
    id: "mapping"
    title: "Edit Field Mapping"
    isEnabled: -> true
  ]
  for step, index in $scope.steps when step.id == $routeParams.step
    step.active = true
    $scope.activeStep = step
    $scope.activeStepIndex = index
    break

  $scope.nextStep = ->
    nextStep = $scope.steps[$scope.activeStepIndex+1]
    $location.url("/step/" + nextStep.id) if nextStep

  console.log "active step", $scope.activeStep
  $location.url("/step/#{$scope.steps[0].id}") unless $scope.activeStep

module.exports.$inject = [ "$scope", "$routeParams", "$location" ]