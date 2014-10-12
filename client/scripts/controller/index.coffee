module.exports = angular.module "app.controllers", []
  .controller "WizardCtrl", require "./wizard"
  .controller "TemplateCtrl", require "./template"
  .controller "ConnectCtrl", require "./connect"
  .controller "DatasourceCtrl", require "./datasource"
  .controller "MappingCtrl", require "./mapping"
  .controller "OutputCtrl", require "./output"