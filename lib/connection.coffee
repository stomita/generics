jsforce = require "jsforce"
Promise = require "promise"

class Connection
  @create: (config) ->
    conn = new jsforce.Connection(config)
    if config.username && config.password
      conn.login(config.username, config.password).then -> conn
    else
      Promise.resolve(conn)

module.exports = Connection