# Code ran by the worker process that performs synchronous XHR.

fs = require 'fs'

if require.main is module
  metadata = JSON.parse fs.readFileSync('meta', encoding: 'utf8')
  if fs.existsSync 'body'
    body = fs.readFileSync 'body'
  else
    body = null
  
  xhr = new XMLHttpRequest()
  xhr.open metadata.method, metadata.url
  xhr.send body
  
