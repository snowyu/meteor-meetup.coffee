'use strict'

angular.module 'meetupApp'
.controller 'SettingDetailCtrl', ($scope, $stateParams, $meteor) ->
  $scope.setting = $scope.$meteorObject Settings, 'main'
  $scope.$meteorSubscribe('settings')

  $scope.save = () ->
    if $scope.form.$valid
      $scope.setting.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
          $scope.updateSetting()
        (error) ->
          console.log 'save error ', error
      )

  $scope.reset = () ->
    $scope.setting.reset()
