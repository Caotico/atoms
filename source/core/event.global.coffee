# ###
# Event emitter which provides the pub/sub pattern to Atoms classes.

# @namespace Atoms.Core
# @class Event

# @author Ignacio Olalde Ramos <ina@tapquo.com> || @piniphone
# ###
# "use strict"

# Atoms.Event = do ->

#   BINDINGS = null

#   bind = (event, callback) ->
#     BINDINGS = BINDINGS or {}
#     BINDINGS[event] = BINDINGS[event] or []
#     BINDINGS[event].push callback

#   unbind = (event, callback) ->
#     BINDINGS = BINDINGS or {}
#     return if event of BINDINGS is false
#     BINDINGS[event].splice BINDINGS[event].indexOf(callback), 1

#   trigger = (event, args...) ->
#     console.log "Trigger :: #{event}"
#     BINDINGS = BINDINGS or {}
#     return if event of BINDINGS is false
#     callback.apply(callback, args) for callback in BINDINGS[event]


#   bind    : bind
#   unbind  : unbind
#   trigger : trigger
#   bindings: -> BINDINGS
