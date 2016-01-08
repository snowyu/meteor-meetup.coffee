'use strict'

angular.module 'meetupApp'
.controller 'ActivitiesListCtrl', ($scope, $meteor, currentUser) ->
  unless currentUser
    $state.go 'register'
    return
  $scope.activities = $scope.$meteorCollection -> Activities.find {}, {sort: ownerName: -1}
  $scope.images = $meteor.collectionFS(Images, false, Images).subscribe('images')
  $scope.newActivity = {}
  fileObj = null
  $scope.isUploaded = ->
    fileObj and fileObj.url and fileObj.url()

  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('activities')

  $meteor.session 'activitiesCounter'
  .bind $scope, 'page'

  $scope.save = () ->
    if $scope.form.$valid
      console.log $scope.form.file
      console.log $scope.ngfImage
      fileObj = Images.insert $scope.ngfImage
      unwatchIt = $scope.$watch "isUploaded()", (newValue, oldValue)->
        if newValue
          console.log 'image.url=', newValue
          $scope.newActivity.image = newValue
          $scope.activities.save $scope.newActivity
          $scope.newActivity = {}
          unwatchIt()

  $scope.remove = (activity) ->
    $scope.activities.remove activity
