module.exports = ($scope, $http, $location) ->
  handleError = (err) ->
    $location.url("/step/connect") if err.status == 401
    console.error err
    null
  $scope.setValue("mapping", {}) unless $scope.mapping
  $location.url("/step/template") unless $scope.template
  $location.url("/step/datasource") unless $scope.reportId
  $scope.reportMeta =
    $http.get "/api/reports/#{$scope.reportId}/metadata"
      .then (res) ->
        console.log res.data
        res.data
      .catch handleError
  $scope.startPreview = ->
    console.log "startPreview", $scope.mapping

module.exports.$inject = [ "$scope", "$http", "$location" ]