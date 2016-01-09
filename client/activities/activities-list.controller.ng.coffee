'use strict'

angular.module 'meetupApp'
.controller 'ActivitiesListCtrl', ($scope, $state, currentUser) ->
  console.log 'auth', $scope.$auth.currentUser
  console.log 'currentUser', currentUser
  unless currentUser
    $state.go 'register'
    return
  $scope.subscribe 'images'
  # Each helper function should return a MongoDB Cursor
  # and the helpers will expose it as a normal array to the context.
  $scope.helpers
    settings: -> Settings.findOne 'main'
    activities: -> Activities.find {}, {sort: ownerName: -1}
    images: -> Images.find()

  # $scope.activities = $scope.$meteorCollection -> Activities.find {}, {sort: ownerName: -1}
  # $scope.images = $meteor.collectionFS(Images, false, Images).subscribe('images')

  $scope.btnStart = '开始'

  $scope.toggleStart = ->
    Settings.update 'main', $set: fetchEnabled: !$scope.settings.fetchEnabled
  $scope.$watch 'settings.fetchEnabled', (newValue, oldValue)->
    $scope.btnStartText = if newValue then '停止' else '开始'

  $scope.isEnabled = (activity)-> activity.enabled
  $scope.toogleEnabled = (activity)-> Activities.update(activity._id, $set: 'enabled': !activity.enabled)

  $scope.clearFetchedActivity = ->
    Activities.find(ownedBy: $ne: null).forEach (activity) ->
      Activities.remove activity._id
    #Meteor.call 'removeActivity', {}

  $scope.newActivity = {}
  fileObj = null
  $scope.isUploaded = ->
    fileObj and fileObj.url and fileObj.url()

  # $meteor.autorun $scope, () ->
  #   $scope.$meteorSubscribe('activities')

  # $meteor.session 'activitiesCounter'
  # .bind $scope, 'page'

  $scope.save = () ->
    if $scope.form.$valid
      console.log $scope.form.file
      console.log $scope.ngfImage
      fileObj = Images.insert $scope.ngfImage
      unwatchIt = $scope.$watch "isUploaded()", (newValue, oldValue)->
        if newValue
          console.log 'image.url=', newValue
          $scope.newActivity.image = newValue
          Activities.insert $scope.newActivity
          $scope.newActivity = {}
          unwatchIt()

  $scope.remove = (activity) ->
    Activities.remove activity._id
