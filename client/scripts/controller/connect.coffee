module.exports = ($scope, $http) ->
  $scope.loading = true
  $scope.identity =
    $http.get "/api/identity"
      .then (res) ->
        console.log res
        res.data
      .catch (err) ->
        $scope.loading = false
        null
      .then (res) ->
        $scope.loading = false
        res

module.exports.$inject = [ "$scope", "$http" ]