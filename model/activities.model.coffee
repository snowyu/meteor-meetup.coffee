@Activities = new Mongo.Collection('activities')

###
* image
* name
* description
* answer
* ownedBy
###
Activities.allow
  insert: (userId, activity) ->
    if userId
      user = Meteor.user()
      if user.username == 'admin'
        activity.createdAt = new Date()
        activity.createdBy = userId
        #Unused.insert(_id: activity._id)
      else
        userId = 0
    userId
  update: (userId, activity, fields, modifier) ->
    if userId
      user = Meteor.user()
      if user.username == 'admin' or !activity.ownedBy
        activity.updatedAt = new Date()
        activity.updatedBy = userId
      else
        userId = 0
    userId
  remove: (userId, activity) ->
    if userId
      user = Meteor.user()
      userId = user.username == 'admin'
      #Unused.remove(activity._id) if userId
    userId
