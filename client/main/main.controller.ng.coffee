'use strict'

angular.module 'meetupApp'
.controller 'MainCtrl', ($scope, $meteor) ->
  $scope.things = $scope.$meteorCollection Things
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('things')

  $meteor.session 'thingsCounter'
  .bind $scope, 'page'
    
  $scope.save = () ->
    if $scope.form.$valid
      $scope.things.save $scope.newThing
      $scope.newThing = undefined
      
  $scope.remove = (thing) ->
    $scope.things.remove thing
