'use strict'

angular.module 'meetupApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'settings-list',
    url: '/settings'
    templateUrl: 'client/settings/settings-list.view.html'
    controller: 'SettingsListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        console.log Meteor.user()
        $meteor.requireUser()
      ]
  .state 'setting-detail',
    url: '/settings/:settingId'
    templateUrl: 'client/settings/setting-detail.view.html'
    controller: 'SettingDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
