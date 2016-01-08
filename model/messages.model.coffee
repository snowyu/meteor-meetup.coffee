@Messages = new Mongo.Collection('messages')

Messages.allow
  insert: (userId, message) ->
    message.createdAt = new Date()
    if userId
      user = Meteor.users.findOne({_id: userId})
      username = user.username
      message.createdBy = userId unless message.createdBy #and username is 'admin'
    message.username = username if username and !message.username
    console.log userId, ' insert', message
    userId
  update: (userId, message, fields, modifier) ->
    if userId
      user = Meteor.user()
      userId = user.username == 'admin'
      message.updatedAt = new Date()
      message.updatedBy = userId
    userId
  remove: (userId, message) ->
    if userId
      user = Meteor.user()
      userId = user.username == 'admin'
    userId
