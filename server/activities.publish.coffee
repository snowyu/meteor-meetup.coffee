'use strict'

Meteor.methods
  removeAllActivity: ->
    user = Meteor.user()
    if user and user.username == 'admin'
      #users = Meteor.users
      Activities.remove {}
    else
      throw new Meteor.Error("not-authorized")

# Meteor.publish 'activities', (options, searchString) ->
#   where =
#     'name':
#       '$regex': '.*' + (searchString or '') + '.*'
#       '$options': 'i'
#   Counts.publish this, 'numberOfMessages', Activities.find(where), noReady: true
#   Activities.find where, options