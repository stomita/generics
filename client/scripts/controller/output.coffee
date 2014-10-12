module.exports = ($scope, $http, $location) ->
  handleError = (err) ->
    $location.url("/step/connect") if err.status == 401
    console.error err
    null
  $location.url("/step/template") unless $scope.template
  $location.url("/step/datasource") unless $scope.reportId
  $location.url("/step/mapping") unless $scope.mapping

  $scope.clouds = [
    name: "heroku"
    title: "Heroku"
    imageUrl: "/images/heroku.png"
  ,
    name: "aws"
    title: "Amazon Web Service S3"
    imageUrl: "/images/aws_s3.png"
  ,
    name: "github"
    title: "Github Pages"
    imageUrl: "/images/github.png"
  ]

  $scope.selectCloud = (cloud) ->
    return alert("Service is not supported yet.") if cloud.name != "aws"
    $scope.loading = true
    $scope.outputResult =
      $http.post "/api/output",
        mapping: $scope.mapping
        reportId: $scope.reportId
        template: $scope.template
        outputTo: cloud.name
      .then (res) ->
        console.log res.data
        $scope.setValue("siteUrl", res.data.url)
        $scope.loading = false
        $scope.nextStep()
      .catch handleError

module.exports.$inject = [ "$scope", "$http", "$location" ]