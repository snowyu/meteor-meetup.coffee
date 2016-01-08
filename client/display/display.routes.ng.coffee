'use strict'

angular.module 'meetupApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'display',
    url: '/display'
    templateUrl: 'client/display/display.view.html'
    controller: 'DisplayCtrl'
