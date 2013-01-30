describe 'XMLHttpRequest', ->
  beforeEach ->
    @xhr = new XMLHttpRequest
    @dripUrl = 'https://localhost:8911/_/drip'
    @dripJson = drips: 3, size: 500, ms: 50

  describe 'new-school events', ->
    beforeEach ->
      @events = []
      @endFired = false
      @eventCheck = -> null  # replaced by tests
      @xhr.addEventListener 'loadstart', (event) =>
        expect(event.type).to.equal 'loadstart'
        expect(@endFired).to.equal false
        @events.push event
      @xhr.addEventListener 'progress', (event) =>
        expect(event.type).to.equal 'progress'
        expect(@endFired).to.equal false
        @events.push event
      @xhr.addEventListener 'load', (event) =>
        expect(event.type).to.equal 'load'
        expect(@endFired).to.equal false
        @events.push event
      @xhr.addEventListener 'loadend', (event) =>
        expect(event.type).to.equal 'loadend'
        expect(@endFired).to.equal false
        @endFired = 'loadend already fired'
        @events.push event
        @eventCheck()
      @xhr.addEventListener 'error', (event) =>
        expect(event.type).to.equal 'error'
        expect(@endFired).to.equal false
        @events.push event
      @xhr.addEventListener 'abort', (event) =>
        expect(event.type).to.equal 'abort'
        expect(@endFired).to.equal false
        @events.push event

    describe 'for a successful fetch with Content-Length set', ->
      beforeEach ->
        @xhr.open 'POST', @dripUrl
        @xhr.send JSON.stringify(@dripJson)

      it 'events have the correct target', (done) ->
        @eventCheck = =>
          for event in @events
            expect(event.target).to.equal @xhr
          done()

      it 'events have the correct bubbling setup', (done) ->
        @eventCheck = =>
          for event in @events
            expect(event.currentTarget).to.equal @xhr
            expect(event.bubbles).to.equal false
            expect(event.cancelable).to.equal false
          done()

      it 'events have the correct progress info', (done) ->
        @eventCheck = =>
          for event in @events
            switch event.type
              when 'loadstart'
                expect(event.loaded).to.equal 0
                expect(event.lengthComputable).to.equal false
                expect(event.total).to.equal 0
              when 'load', 'loadend'
                console.log event
                expect(event.loaded).to.equal 1500
                expect(event.lengthComputable).to.equal true
                expect(event.total).to.equal 1500
              when 'progress'
                if event.lengthComputable
                  expect(event.loaded).to.be.gte 0
                  expect(event.loaded).to.be.lte 1500
                  expect(event.total).to.equal 1500
                else
                  expect(event.loaded).to.be.gte 0
                  expect(event.total).to.equal 0
          done()
