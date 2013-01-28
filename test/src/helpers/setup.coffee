if typeof window is 'undefined'
  # node.js
  global.XMLHttpRequest = require '../../../lib/xhr2'
  global.NetworkError = XMLHttpRequest.NetworkError
  global.SecurityError = XMLHttpRequest.SecurityError
  global.InvalidStateError = XMLHttpRequest.InvalidStateError

  global.chai = require 'chai'
  global.assert = global.chai.assert
  global.expect = global.chai.expect
  global.sinon = require 'sinon'
  global.sinonChai = require 'sinon-chai'

  xhrServer = require './xhr_server'
  require './xhr2.png.js'
else
  # browser
  window.NetworkError = window.Error
  window.SecurityError = window.Error
  window.assert = window.chai.assert
  window.expect = window.chai.expect
