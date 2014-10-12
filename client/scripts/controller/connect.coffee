module.exports = ($scope, $http) ->
  $scope.loading = true
  $http.get "/api/identity"
    .then (res) ->
      console.log res
      $scope.identity = res.data
      $scope.loading = false
    , (err) ->
      console.error err
      $scope.identity = null
      $scope.loading = false

module.exports.$inject = [ "$scope", "$http" ]