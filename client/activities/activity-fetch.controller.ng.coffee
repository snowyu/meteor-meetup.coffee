'use strict'

angular.module 'meetupApp'
.controller 'ActivityFetchCtrl', ($scope, $reactive, $state, $window, $meteor, currentUser) ->
  $reactive(this).attach($scope);
  # @helpers
  #   activities: ->
  #     # workaround the minimongo bug: no supported for $eq on mongodb 3
  #     Activities.find(ownedBy: $not: $ne: null).fetch()

  # Returns a random integer between min (included) and max (exclude)
  getRandomInt = (min, max)-> Math.floor(Math.random() * (max - min)) + min
  # triggle subscribe if not # now I know how to waitToGet the user.
  # currentUser = Meteor.user() #unless currentUser # sometime the currentUser is not setting.
  # triggle subscribe if not

  $scope.subscribe 'settings', angular.noop, onReady:->
    console.log('ready settings')

    console.log 'a=', $scope.settings # where to wait for the collection sync from datbases?
    console.log 's=', Settings.findOne('main') # where to wait for the collection sync from datbases?

    #currentUser = $scope.currentUser #Meteor.user()
    #currentUser = Meteor.user() unless currentUser # sometime the currentUser is not setting.
    #console.log ''
    #console.log '.user',currentUser
    #console.log '.user',Meteor.user()
    console.log 'act:currentUser', currentUser
    unless currentUser
      #unsubscribe.stop()
      $state.go 'register'
      return

    settings = Settings.findOne('main') #unless settings
    console.log 'settings:', settings
    fetchEnabled = settings.fetchEnabled
    console.log 'fetchEnabled:', fetchEnabled
    if fetchEnabled
      unless currentUser.profile and currentUser.profile.activity
        # workaround the minimongo bug: no supported for $eq on mongodb 3
        activity = Activities.find(enabled:true, ownedBy: $not: $ne: null).fetch()
        #activity = Activities.find().fetch()
        i = activity.length
        console.log 'actCount', i, activity
        if i
          i = getRandomInt 0, i
          activity = activity[i]

          console.log i, activity, ' uid=', currentUser._id
          Activities.update activity._id, $set:
            ownedBy: currentUser._id
            ownerName: currentUser.username
          Meteor.users.update currentUser._id, $set: 'profile.activity': activity._id
          console.log 'activity=', activity.name
          s = activity.name
          Messages.insert
            username: '【系统】'
            createdBy: 'sys'
            content: '恭喜【'+currentUser.username+'】:thumbup: 获得参与【' + s + '】机会!'
    #unsubscribe.stop()
    $state.go 'messages'
  return


