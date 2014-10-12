var app = angular.module('SiteGenerics', [
  "ngRoute",
  "ngTouch",
  "mobile-angular-ui"
]);

app.config(function($routeProvider, $locationProvider) {
  $routeProvider
    .when('/', {
      templateUrl: "partials/list.html"
    })
    .when('/record/:id', {
      templateUrl: "partials/detail.html"
    });
});

app.controller('MainController', function($rootScope, $scope, $http, $location){

  $rootScope.$on("$routeChangeStart", function(){
    $rootScope.loading = true;
  });

  $rootScope.$on("$routeChangeSuccess", function(){
    $rootScope.loading = false;
  });

  $http.get("/data/root.json").then(function(res) {
    $scope.title = res.data.title;
    $scope.records = res.data.records;
    console.log($scope.records);
  });
  $scope.showDetail = false;
  $scope.$on("showDetail", function(){ $scope.showDetail = true; });
  $scope.goback = function() { history.back(); };
});

app.controller('ItemDetailController', function($scope, $routeParams) {
  console.log($scope.records);
  $scope.$emit("showDetail");
  var recordId = $routeParams.id;
  $scope.record = _.find($scope.records, function(record) { return record.id === recordId; });
});