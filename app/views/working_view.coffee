timerTemplate = require('./templates/timer')

class exports.WorkingView extends Backbone.View
  el: "#modal"

  events:
    "click #cancel": "resetTimer"

  render: ->
    @$(@el).html timerTemplate(title: "Working")
    @$(@el).modal(backdrop: 'static', show: true)
    @

  startTimer: (seconds) =>
    $('#timer').startTimer(
      seconds: seconds,
      reset: false,
      show_in_title: true,
      buzzer: @buzzer
    )

  buzzer: =>
    # add pomodoro
    app.collections.pomodoros.create(created_at: new Date().getTime())

    # ring alarm
    app.audios.alarm.play()

    # show notification
    notification = webkitNotifications.createNotification(
      'images/tomato_32.png',
      'notification',
      'pomodoro is done!'
    )
    notification.show()

    # hide modal
    @$(@el).modal('hide')

    app.routers.main.navigate('home', true)


  resetTimer: ->
    $("#timer").clearTimer()

    # hide modal
    @$(@el).modal('hide')

    app.routers.main.navigate('home', true)