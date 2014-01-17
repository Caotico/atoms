###
Base class for Atom

@namespace Atoms.Class
@class Atom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Atom extends Atoms.Core.Module

  @include Atoms.Core.Event
  @include Atoms.Core.Output

  constructor: (@attributes) ->
    super
    @type = "Atom"
    @output()
    @listenEvents()

    if @attributes.events
      for evt in @attributes.events
        @el.on evt, do (evt) => (event) =>
          @bubble evt, event, @

  listenEvents: ->
    @listens = @listens or {}
    for eventName, callbackName of @listens
      @listen eventName, @[callbackName]
