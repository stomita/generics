app = require "../app"
jsforce = require "jsforce"

app.get "/api/connection", (req, res) ->
  if req.session.accessToken && req.session.instanceUrl
    conn = new jsforce.Connection
      accessToken: req.session.accessToken
      instanceUrl: req.session.instanceUrl
    conn.identity().then (identity) ->
      res.send { identity: identity }
  else
    res.send { error: "NO_CONNECTION", message: "No connection found in server." }, 401