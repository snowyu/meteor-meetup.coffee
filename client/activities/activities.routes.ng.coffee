'use strict'

angular.module 'meetupApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'activities-list',
    url: '/activities'
    templateUrl: 'client/activities/activities-list.view.html'
    controller: 'ActivitiesListCtrl'
    resolve:
      currentUser: ($auth) ->
        $auth.waitForUser()
  .state 'activity-fetch',
    url: '/activities/fetch'
    controller: 'ActivityFetchCtrl'
    resolve:
      currentUser: ($auth) ->
        $auth.waitForUser()
  .state 'activity-detail',
    url: '/activities/:activityId'
    templateUrl: 'client/activities/activity-detail.view.html'
    controller: 'ActivityDetailCtrl'
    resolve:
      currentUser: ($auth) ->
        $auth.waitForUser()
