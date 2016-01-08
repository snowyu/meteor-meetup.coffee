'use strict'

Meteor.publish 'settings',  ->
  Settings.find({});
