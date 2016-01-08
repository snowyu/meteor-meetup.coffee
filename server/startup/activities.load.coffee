Meteor.startup ->
  if Meteor.reset
    console.warn 'Activities deleted'
    Activities.remove({})
  if Activities.find().count() == 0
    activities = for i in [1..10]
      'name': 'activity '+ i
      'description': 'this is activity '+ i
      'answer': 'this is answer ' + i

    activities.forEach (activity) ->
      Activities.insert activity