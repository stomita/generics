module.exports = ($scope, $http) ->
  $http.get "/api/connection"
    .then (res) ->
      console.log res
      res.data

module.exports.$inject = [ "$scope", "$http" ]