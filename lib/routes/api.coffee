app = require "../app"
jsforce = require "jsforce"

###
#
###
app.all "/api/*", (req, res, next) ->
  if req.session.accessToken && req.session.instanceUrl
    next()
  else
    res.send { error: "NO_CONNECTION", message: "No connection found in server." }, 401

###
#
###
app.get "/api/identity", (req, res) ->
  conn = new jsforce.Connection
    accessToken: req.session.accessToken
    instanceUrl: req.session.instanceUrl
  conn.identity().then (identity) ->
    res.send identity
  , (err) ->
    res.send err, 500

###
#
###
app.get "/api/reports", (req, res) ->
  conn = new jsforce.Connection
    accessToken: req.session.accessToken
    instanceUrl: req.session.instanceUrl
  conn.analytics.reports().then (reports) ->
    res.send reports
  , (err) ->
    res.send err, 500


###
#
###
app.get "/api/reports/:reportId/metadata", (req, res) ->
  conn = new jsforce.Connection
    accessToken: req.session.accessToken
    instanceUrl: req.session.instanceUrl
  reportId = req.param('reportId')
  conn.analytics.report(reportId).describe().then (ret) ->
    meta = ret.reportMetadata
    extMeta = ret.reportExtendedMetadata
    columns =
      for colName in meta.detailColumns
        colInfo = extMeta.detailColumnInfo[colName]
        {
          name: colName
          label: colInfo.label
          type: colInfo.dataType
        }
    res.send
      name: meta.name
      columns: columns
  , (err) ->
    res.send err, 500


###
#
###
app.get "/api/templates", (req, res) ->
  res.send [{
    "title": "Sunnyvale",
    "preview": "/images/templates/sunnyvale/preview.png"
    "fields": [{
      "name": "title",
      "label": "Title",
      "type": "string"
    }, {
      "name": "description",
      "label": "Description",
      "type": "longtext"
    }, {
      "name": "previewPhotoUrl",
      "label": "Preview Photo",
      "type": "string"
    }, {
      "name": "icon1",
      "label": "Icon #1",
      "type": "string"
    }, {
      "name": "icon2",
      "label": "Icon #2",
      "type": "string"
    }, {
      "name": "icon3",
      "label": "Icon #3",
      "type": "string"
    }]
  }]