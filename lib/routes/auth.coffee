app = require "../app"
jsforce = require "jsforce"

oauth2 = new jsforce.OAuth2
  clientId: process.env.SF_CLIENT_ID
  clientSecret: process.env.SF_CLIENT_SECRET
  redirectUri: process.env.SF_REDIRECT_URI

###
# OAuth dance for Salesforce
###
app.get "/auth/salesforce", (req, res) ->
  state = require('crypto').randomBytes(48).toString('base64')
  req.session.state = state
  authzUrl = oauth2.getAuthorizationUrl(state: state)
  res.redirect authzUrl


app.get "/auth/salesforce/callback", (req, res) ->
  error = req.param("error")
  return res.send "Error: #{error}" if error
  return res.send "Error: No state parameter given" if req.session.state != req.param("state")
  code = req.param("code")
  return res.send "Error: No code parameter given" unless code
  oauth2.requestToken(code)
    .then (result) ->
      req.session.accessToken = result.access_token
      req.session.instanceUrl = result.instance_url
      res.redirect "/#/step/connect"
    .fail (err) ->
      console.error err
      return res.send "#{err.message}"

