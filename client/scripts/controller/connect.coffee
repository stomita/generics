module.exports = ($scope, $http) ->
  $scope.loading = true
  $http.get "/api/connection"
    .then (res) ->
      console.log res
      $scope.loading = false
      $scope.connection = res.data
    , (err) ->
      console.error err
      $scope.connection = null
      $scope.loading = false

module.exports.$inject = [ "$scope", "$http" ]