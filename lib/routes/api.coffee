app = require "../app"
jsforce = require "jsforce"

###
#
###
app.all "/api/*", (req, res, next) ->
  if req.url == "/api/templates" || (req.session.accessToken && req.session.instanceUrl)
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


getRecords = (conn, reportId, mapping) ->
  conn.analytics.report(reportId).execute(details: true).then (result) ->
    meta = result.reportMetadata
    {
      title: meta.title
      records:
        for row, i in result.factMap["T!T"]?.rows || []
          record = {}
          for cell, index in row.dataCells
            record[meta.detailColumns[index]] =
              if /^<a\s+/.test(cell.label) then cell.value else cell.label
          mappedRecord = { id: String(i) }
          for field, column of mapping
            mappedRecord[field] = record[column]
          mappedRecord
    }

saveDataAsTemplate = (templateName, result) ->
  # TODO
  {
    url: "http://#{process.env.S3_OUTPUT_BUCKET}.s3-website-us-east-1.amazonaws.com"
  }

###
#
###
app.post "/api/output", (req, res) ->
  reportId = req.body.reportId
  mapping = req.body.mapping
  template = req.body.template
  conn = new jsforce.Connection
    accessToken: req.session.accessToken
    instanceUrl: req.session.instanceUrl
  getRecords(conn, reportId, mapping)
    .then (result) ->
      saveDataAsTemplate(template.name, result)
    .then (result) ->
      res.send result
    , (err) ->
      res.send err, 500



###
#
###
app.get "/api/templates", (req, res) ->
  res.send [{
    "name": "simple",
    "title": "Simple",
    "previewUrl": "/templates/simple/images/preview.png",
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
  }, {
    "name": "sunnyvale",
    "title": "Sunnyvale",
    "previewUrl": "/templates/sunnyvale/images/preview.png"
  }, {
    "name": "redmond",
    "title": "Redmond",
    "previewUrl": "/templates/redmond/images/preview.png"
  }]