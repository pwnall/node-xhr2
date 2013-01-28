# This file defines the custom errors used in the XMLHttpRequest specification.

# Thrown if the XHR security policy is violated.
class SecurityError extends Error
  constructor: -> super

XMLHttpRequest.SecurityError = SecurityError


# Usually thrown if the XHR is in the wrong readyState for an operation.
class InvalidStateError extends Error
  constructor: -> super

XMLHttpRequest.InvalidStateError = InvalidStateError

# Thrown if there is a problem with the URL passed to the XHR.
class NetworkError extends Error
  constructor: -> super

XMLHttpRequest.NetworkError
