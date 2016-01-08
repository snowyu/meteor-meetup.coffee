Meteor.startup ->
  if Meteor.reset
    console.warn 'Settings deleted'
    Settings.remove({})
  if Settings.find().count() == 0
    settings = [
      {
        '_id': 'main'
        'title': '重庆IoT新年联会'
        'subtitle': '物联利浪'
        'qrCodeSize': 512
        'fetchEnabled': false
      }
    ]
    settings.forEach (setting) ->
      Settings.insert setting