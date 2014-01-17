###
Event emitter which provides the pub/sub pattern to Atoms classes.

@namespace Atoms.Core
@class Event

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Event =

  bindings: null

  ###
  Attach a handler to an event for the class.
  @method bind
  @param  {string}    A string containing one or more event/custom types.
  @param  {function}  A function to execute each time the event is triggered.
  ###
  bind: (events, callback) ->
    events = events.split(' ')
    calls = @hasOwnProperty('events') and @events or = {}
    for event in events
      event = @_parseName event
      calls[event] or = []
      calls[event].push callback

  ###
  Remove a previously-attached event handler from the class.
  @method unbind
  @param  {string}    A string containing one or more event/custom types.
  @param  {function}  The function that is to be no longer executed.
  ###
  unbind: (event, callback) ->
    event = @_parseName event
    if @hasOwnProperty('events') and @events?[event]
      @events[event].splice @events[event].indexOf(callback), 1

  ###
  Execute all handlers and behaviors attached to the matched class for the given
  event type.
  @method trigger
  @param  {string}    A string containing one or more event/custom types.
  @param  {array}     [OPTIONAL] Additional parameters to pass along to the event
                      handler.
  ###
  trigger: (event, args...) ->
    if not @parentClass
      console.warn "WARNING! No parent found for #{@type}:#{@constructor.name}"

    event = @_parseName event
    events = @hasOwnProperty('events') and @events?[event]
    return unless events
    args.push @
    for event in events
      break if event.apply(@, args) is false

  listen: (event, callback) ->
    eventNS = "#{event}"
    @events = @events or {}
    @events[eventNS] = @events[eventNS] or []
    @events[eventNS].push callback

  bubble: (event, args...) ->
    if not @parentClass
      console.warn "WARNING BUBBLING! #{@type}:#{@constructor.name} parent class??"

    eventNS = "#{@constructor.name}:#{event}"
    return unless @parentClass.events?[eventNS]?
    for callback in @parentClass.events[eventNS]
      break if callback.apply(callback, args) is false
    @parentClass.bubble event, args


  #@TODO :: How I Know who are my children?
  tunnel: (event, args...) ->
    eventNS = "#{@constructor.name}:#{event}"
    for child in @attributes.children
      if child.events[eventNS]
        child.events[eventNS].apply(child.events[eventNS], args)



  ###
  Attach a handler to a list of a events for the class.
  @method bindList
  @param  {DOM}       Element in DOM.
  @param  {string}    Name of class.
  @param  {array}     List of events to subscribe.
  ###
  bindList: (instance, events) ->
    class_lower = instance.constructor.name.toLowerCase()
    for event in events
      event = "#{instance.constructor.name}:#{event}"
      callback_name = "#{class_lower}#{Atoms.Core.Helper.className(event)}"
      instance.bind event, @[callback_name]

  # Private Methods
  _parseName: (event) -> "#{@type}:#{@constructor.name}:#{event}"
