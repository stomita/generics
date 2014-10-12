angular = require "angular"

app = angular.module "app", [
  "ngRoute"
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
      templateUrl: "templates/wizard.html"
    .otherwise
      templateUrl: "templates/error.html"
]

.controller "MainCtrl", [ "$scope", ($scope) ->

]
