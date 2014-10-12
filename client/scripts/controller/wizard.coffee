module.exports = ($scope, $routeParams, $location) ->
  $scope.steps = [
    id: "start"
    title: "Start"
  ,
    id: "connect"
    title: "Connection"
  ,
    id: "template"
    title: "Template"
  ,
    id: "datasource"
    title: "Data Source"
  ,
    id: "mapping"
    title: "Field Mapping"
  ,
    id: "output"
    title: "Output"
  ,
    id: "complete"
    title: "Complete"
  ]
  for step, index in $scope.steps when step.id == $routeParams.step
    step.active = true
    $scope.activeStep = step
    $scope.activeStepIndex = index
    break

  $scope.nextStep = ->
    nextStep = $scope.steps[$scope.activeStepIndex+1]
    $location.url("/step/" + nextStep.id) if nextStep

  $scope.prevStep = ->
    prevStep = $scope.steps[$scope.activeStepIndex-1]
    $location.url("/step/" + prevStep.id) if prevStep

  console.log "active step", $scope.activeStep
  $location.url("/step/#{$scope.steps[0].id}") unless $scope.activeStep

module.exports.$inject = [ "$scope", "$routeParams", "$location" ]