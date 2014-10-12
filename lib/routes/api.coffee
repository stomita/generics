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