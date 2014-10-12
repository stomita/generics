module.exports = ($scope, $http, $location) ->
  handleError = (err) ->
    $location.url("/step/connect") if err.status == 401
    console.error err
    null
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
  $scope.activeReport = null
  $scope.$watch "activeReport", (report) ->
    $scope.metadata =
      $http.get "/api/reports/#{report.id}/metadata"
        .then (res) ->
          console.log res.data
          res.data
        .catch handleError
        .then (res) ->
          $scope.loading = false
          res

module.exports.$inject = [ "$scope", "$http", "$location" ]