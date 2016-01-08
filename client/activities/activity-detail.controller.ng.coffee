'use strict'

angular.module 'meetupApp'
.controller 'ActivityDetailCtrl', ($scope, $stateParams, $meteor, currentUser) ->
  unless currentUser
    $state.go 'register'
    return
  $scope.activity = $scope.$meteorObject Activities, $stateParams.activityId
  $scope.$meteorSubscribe('activities')
  $scope.helpers
    owner: -> $scope.activity.ownedBy and Meteor.users.findOne $scope.activity.ownedBy

  fileObj = null
  $scope.isUploaded = ->
    fileObj and fileObj.url and fileObj.url()

  $scope.save = () ->
    if $scope.form.$valid
      fileObj = Images.insert $scope.ngfImage
      unwatchIt = $scope.$watch "isUploaded()", (newValue, oldValue)->
        if newValue
          console.log 'image.url=', newValue
          $scope.activity.image = newValue

          $scope.activity.save().then(
            (numberOfDocs) ->
              console.log 'save successful, docs affected ', numberOfDocs
            (error) ->
              console.log 'save error ', error
          )
          unwatchIt()

  $scope.reset = () ->
    $scope.activity.reset()
