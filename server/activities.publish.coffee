'use strict'

# Meteor.publish 'activities', (options, searchString) ->
#   where =
#     'name':
#       '$regex': '.*' + (searchString or '') + '.*'
#       '$options': 'i'
#   Counts.publish this, 'numberOfMessages', Activities.find(where), noReady: true
#   Activities.find where, options