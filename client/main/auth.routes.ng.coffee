'use strict'

angular.module 'meetupApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'register',
    url: '/register'
    template: '<register></register>'
