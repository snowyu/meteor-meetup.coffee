Meteor.startup ->
  if Meteor.reset
    console.warn 'Settings deleted'
    Settings.remove({})
  if Settings.find().count() == 0
    settings = [
      {
        '_id': 'main'
        'title': 'IoT新年联会'
        'subtitle': '物联公司'
        'qrCodeSize': 512
        'fetchEnabled': false
      }
    ]
    settings.forEach (setting) ->
      Settings.insert setting