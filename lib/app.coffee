
app = angular.module 'NwTimerApp', []

app.controller 'MainCtrl', ($scope) ->

  $scope.clockIsRunning = false

  endTime = -1
  intervalHandle = null
  alarmPlaying = false
  $scope.timeOnClock = "00:00:00"
  $scope.isOverunning = false
  alarmSound = new buzz.sound "sounds/alarm", { formats: [ "ogg", "mp3" ] }

  parseTime = ->
    parts = $scope.timeOnClock.split(":")
    seconds = parseInt(parts[2])
    minutes = parseInt(parts[1])
    hours   = parseInt(parts[0])
    (hours * 3600 + minutes * 60 + seconds) * 1000

  setDisplay = (timeInMs) ->
    hours = Math.floor(timeInMs / 3600000)
    minutes = Math.floor((timeInMs - (hours * 3600000)) / 60000)
    seconds = Math.floor((timeInMs - (minutes * 60000)) / 1000)
    $scope.timeOnClock = ("00" + hours).slice(-2) + ":" + ("00" + minutes).slice(-2) + ":" + ("00" + seconds).slice(-2)

  updateTime = ->
    timeLeft = endTime - new Date().getTime()
    if timeLeft <= 0
      $scope.isOverunning = true
      timeLeft = Math.abs(timeLeft)
      playAlarm() if not alarmPlaying
    else
      stopAlarm() if alarmPlaying
      $scope.isOverunning = false
    setDisplay(timeLeft)

  playAlarm = ->
    alarmPlaying = true
    alarmSound.play().fadeIn().loop()

  stopAlarm = ->
    alarmPlaying = false
    alarmSound.stop()

  timerTick = ->
    $scope.$apply ->
      updateTime()

  $scope.start = ->
    endTime = new Date().getTime() + parseTime()
    $scope.clockIsRunning = true
    stopAlarm()
    updateTime()
    intervalHandle = setInterval(timerTick, 500)

  $scope.stop = ->
    $scope.clockIsRunning = false
    stopAlarm()
    clearInterval(intervalHandle)

  $scope.clear = ->
    $scope.stop()
    $scope.isOverunning = false
    $scope.timeOnClock = "00:00:00"

  $scope.addTime = (secs) ->
    timeLeft = parseTime() + secs * 1000
    console.log endTime
    endTime = endTime + secs * 1000
    console.log endTime
    setDisplay(timeLeft)

  $scope.addNumber = (num) ->
    display = $scope.timeOnClock.replace(/:/g, "")
    ut = display + num
    $scope.timeOnClock = ut.slice(1, 3) + ":" + ut.slice(3, 5) + ":" + ut.slice(5, 7)
    console.log $scope.timeOnClock