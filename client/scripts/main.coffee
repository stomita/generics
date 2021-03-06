angular = require "angular"

app = angular.module "app", [
  "ngRoute"
  "ngAnimate"
  "ui.bootstrap"
  require("./controller").name
]

.config [ "$parseProvider", ($parseProvider) ->
  $parseProvider.unwrapPromises(true)
]

.config [ "$routeProvider", ($routeProvider) ->
  $routeProvider
    .when "/step/:step",
      controller: "WizardCtrl"
      templateUrl: "partials/wizard.html"
    .otherwise
      controller: "WizardCtrl"
      templateUrl: "partials/wizard.html"
]

.controller "MainCtrl", [ "$scope", ($scope) ->
  $scope.setValue = (name, value) ->
    console.log "setValue", name, value
    $scope[name] = value
  $scope.getValue = (name) ->
    value = $scope[name]
    console.log "getValue", name, value
    value
]
