module.exports = ($scope, $routeParams, $location) ->
  $scope.steps = [
    id: "start"
    title: "Start"
  ,
    id: "connect"
    title: "Establish Connection"
  ,
    id: "template"
    title: "Select Template"
  ,
    id: "datasource"
    title: "Choose Data Source"
  ,
    id: "mapping"
    title: "Edit Field Mapping"
  ,
    id: "output"
    title: "Output as Website"
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