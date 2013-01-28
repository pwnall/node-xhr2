# XMLHttpRequest Emulation for node.js

This is an [npm](https://npmjs.org/) package that implements the
[W3C XMLHttpRequest](http://www.w3.org/TR/XMLHttpRequest/) specification on top
of the [node.js](http://nodejs.org/) APIs.


## Supported Platforms

This library is tested against the following platforms.

* [node.js](http://nodejs.org/) 0.6
* [node.js](http://nodejs.org/) 0.8
* [node.js](http://nodejs.org/) 0.9

Keep in mind that the versions above are not hard requirements.


## Installation and Usage

The preferred installation method is to add the library to the `dependencies`
section in your `package.json`.

```json
{
  "dependencies": [
    "xhr2": "*"
  ]
}
```

Alternatively, `npm` can be used to install the library directly.

```bash
npm install xhr2
```

Once the library is installed, `require`-ing it returns the `XMLHttpRequest`
constructor.

```javascript
var XMLHttpRequest = require('xhr2');
```

MDN (the Mozilla Developer Network) has a
[great intro to XMLHttpRequest](https://developer.mozilla.org/en-US/docs/DOM/XMLHttpRequest/Using_XMLHttpRequest).


## Versioning

The library aims to implement the
[W3C XMLHttpRequest](http://www.w3.org/TR/XMLHttpRequest/) specification, so
the library's API will always be a (hopefully growing) subset of the API in the
specification.


## Copyright and License

The library is Copyright (c) 2013 Victor Costan, and distributed under the MIT
License.
