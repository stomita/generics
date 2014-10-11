_ = require "underscore"
Promise = require "promise"
Connection = require "./connection"

class Generics
  constructor: (options) ->
    @connection = options.connection
    @dataset = options.dataset
    @srcDir = options.srcDir || "./src"
    @outDir = options.outDir || "./out"

  generate: ->
    @executeQuery().then (dataset) =>
      @generateOutput(dataset)

  executeQuery: ->
    dataset = {}
    Connection.create(@connection).then (conn) =>
      Promise.all(
        for dsname, dsconfig of @dataset
          conn.sobject(dsconfig.table)
            .find(dsconfig.filter)
            .sort(dsconfig.sort)
            .limit(dsconfig.limit)
            .then (records) ->
              dataset[dsname] = records
      )
    .then ->
      dataset

  generateOutput: (dataset) ->

module.exports = Generics