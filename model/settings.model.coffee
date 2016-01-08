@Settings = new Mongo.Collection('settings')

#Settings.findOne('main')

Settings.allow
  insert: (userId, setting) ->
    if userId
      user = Meteor.user()
      userId = user.username == 'admin'
    userId
  update: (userId, setting, fields, modifier) ->
    if userId
      user = Meteor.user()
      userId = user.username == 'admin'
    userId
  remove: (userId, setting) ->
    if userId
      user = Meteor.user()
      userId = user.username == 'admin'
    userId
