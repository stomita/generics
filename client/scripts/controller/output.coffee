module.exports = ($scope, $http, $location) ->
  handleError = (err) ->
    $location.url("/step/connect") if err.status == 401
    console.error err
    null
  $location.url("/step/template") unless $scope.template
  $location.url("/step/datasource") unless $scope.reportId
  $location.url("/step/mapping") unless $scope.mapping
  $scope.outputResult =
    $http.post "/api/output",
      mapping: $scope.mapping
      reportId: $scope.reportId
      template: $scope.template
    .then (res) ->
      console.log res.data
      res.data
    .catch handleError

module.exports.$inject = [ "$scope", "$http", "$location" ]