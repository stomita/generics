module.exports = ($scope, $http, $location) ->
  handleError = (err) ->
    $location.url("/step/connect") if err.status == 401
    console.error err
    null
  $location.url("/step/template") unless $scope.template
  $scope.loading = true
  $scope.reports =
    $http.get "/api/reports"
      .then (res) ->
        console.log res.data
        res.data
      .catch handleError
      .then (res) ->
        $scope.loading = false
        res

  $scope.selectReport = ->
    console.log "selectReport"
    return unless $scope.reportId
    $scope.setValue("reportId", $scope.reportId)
    $scope.setValue("mapping", {})
    $scope.nextStep()

module.exports.$inject = [ "$scope", "$http", "$location" ]