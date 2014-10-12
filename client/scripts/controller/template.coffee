module.exports = ($scope, $http, $location) ->
  handleError = (err) ->
    $location.url("/step/connect") if err.status == 401
    console.error err
    null
  $scope.loading = true
  $scope.templates =
    $http.get "/api/templates"
      .then (res) ->
        console.log res.data
        res.data
      .catch handleError
      .then (res) ->
        $scope.loading = false
        res
  $scope.selectTemplate = (template) ->
    $scope.setValue("template", template)
    $scope.nextStep()

module.exports.$inject = [ "$scope", "$http", "$location" ]