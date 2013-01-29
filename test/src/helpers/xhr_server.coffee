express = require 'express'
fs = require 'fs'
https = require 'https'
open = require 'open'

# express.js server for testing the Web application.
class XhrServer
  # Starts up a HTTP server.
  constructor: (@port = 8911) ->
    @createApp()

  # Opens the test URL in a browser.
  openBrowser: (appName) ->
    open @testUrl(), appName

  # The URL that should be used to start the tests.
  testUrl: ->
    "https://localhost:#{@port}/test/html/browser_test.html"

  # The server code.
  createApp: ->
    @app = express()

    # Echoes the request body. Used to test send(data).
    @app.post '/_/echo', (request, response) ->
      if request.headers['content-type']
        response.header 'Content-Type', request.headers['content-type']
      if request.headers['content-length']
        response.header 'Content-Length', request.headers['content-length']

      request.on 'data', (chunk) -> response.write chunk
      request.on 'end', -> response.end()

    # Lists the request headers. Used to test setRequestHeader().
    @app.post '/_/headers', (request, response) ->
      body = JSON.stringify request.headers
      response.header 'Content-Type', 'application/json'
      response.header 'Content-Length', body.length.toString()
      response.end body

    # Sets the response headers in the request. Used to test getResponse*().
    @app.post '/_/get_headers', (request, response) ->
      body = ''
      request.on 'data', (chunk) -> body += chunk
      request.on 'end', ->
        headers = JSON.parse body
        for name, value of headers
          response.header name, value
        response.header 'Content-Length', '0'
        response.end ''

    # Requested when the browser test suite completes.
    @app.get '/diediedie', (request, response) =>
      if 'failed' of request.query
        failed = parseInt request.query['failed']
      else
        failed = 1
      total = parseInt request.query['total'] || 0
      passed = total - failed
      exitCode = if failed == 0 then 0 else 1
      console.log "#{passed} passed, #{failed} failed"

      response.header 'Content-Type', 'image/png'
      response.header 'Content-Length', '0'
      response.end ''
      unless 'NO_EXIT' of process.env
        @server.close()
        process.exit exitCode

    # CORS headers on everything, in case that ever gets implemented.
    @app.use (request, response, next) ->
      response.header 'Access-Control-Allow-Origin', '*'
      response.header 'Access-Control-Allow-Methods', 'DELETE,GET,POST,PUT'
      response.header 'Access-Control-Allow-Headers',
                      'Content-Type, Authorization'
      next()

    @app.use express.static(fs.realpathSync(__dirname + '/../../../'),
                            { hidden: true })

    options = key: fs.readFileSync 'test/ssl/cert.pem'
    options.cert = options.key
    @server = https.createServer options, @app
    @server.listen @port

module.exports = new XhrServer
