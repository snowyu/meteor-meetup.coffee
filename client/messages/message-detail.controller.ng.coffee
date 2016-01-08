'use strict'

angular.module 'meetupApp'
.controller 'MessageDetailCtrl', ($scope, $stateParams, $meteor) ->
  $scope.message = $scope.$meteorObject Messages, $stateParams.messageId
  $scope.$meteorSubscribe('messages')
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.message.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.message.reset()
