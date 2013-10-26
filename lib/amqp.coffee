amqp = require("amqp")
uuid = require("uuid")
gui  = require("nw.gui")

class AmqpConnection

  constructor: (@handler) ->
    @connection = amqp.createConnection { host: "localhost", login: "guest", password: "guest" }
    @connection.on "ready", =>
      @queue_name = uuid.v4()
      gui.Window.get().on "close", => @connection.end()
      @connection.queue @queue_name, (q) =>
        @q = q
        @q.bind "#"
        @q.subscribe @receive

  publish: (message, headers) =>
    headers = headers ? {}
    headers.sent = new Date().getTime()
    @connection.publish @queue_name, message, { headers: headers, contentType: "application/json" }

  receive: (msg, headers, deliveryInfo) =>
    headers.received = new Date().getTime()
    message = { headers: headers, body: msg }
    @handler message

  startHeartbeat: (interval) =>
    interval = interval ? 1500
    sendHeartbeat = =>
      @publish { ping: "pong!" }
    @heartbeat_handle = setInterval(sendHeartbeat, interval)

  stopHeartbeat: =>
    if @heartbeat_handle?
      clearInterval(@heartbeat_handle)

window.AmqpConnection = AmqpConnection