express = require "express"
session = require "express-session"
morgan = require "morgan"
methodOverride = require "method-override"
bodyParser = require "body-parser"
errorHandler = require "errorhandler"
http = require "http"
path = require "path"
app = express()
module.exports = app

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "../views")
app.set "view engine", "ejs"
app.use morgan("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use methodOverride()
app.use session(secret: 'secret string')
app.use express.static(path.join(__dirname, "../public"))

# development only
app.use errorHandler()  if "development" is app.get("env")

require "./routes/auth"
require "./routes/connection"

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")