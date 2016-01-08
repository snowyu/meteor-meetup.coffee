'use strict'

# Meteor.publish 'messages', (options, searchString) ->
#   where =
#     'name':
#       '$regex': '.*' + (searchString or '') + '.*'
#       '$options': 'i'
#   Counts.publish this, 'numberOfMessages', Messages.find(where), noReady: true
#   Messages.find where, options