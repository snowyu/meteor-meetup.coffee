Meteor.startup ->
  if Meteor.reset
    console.warn 'Messages deleted'
    Messages.remove({})
  if Messages.find().count() == 0
    messages = [
    ]
    messages.forEach (message) ->
      Messages.insert message