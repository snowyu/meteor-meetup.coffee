'use strict'

angular.module 'meetupApp'
.controller 'SettingsListCtrl', ($scope, $meteor) ->
  $scope.settings = $scope.$meteorCollection Settings
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('settings')

  $meteor.session 'settingsCounter'
  .bind $scope, 'page'
    
  $scope.save = () ->
    if $scope.form.$valid
      $scope.settings.save $scope.newSetting
      $scope.newSetting = undefined
      
  $scope.remove = (setting) ->
    $scope.settings.remove setting
