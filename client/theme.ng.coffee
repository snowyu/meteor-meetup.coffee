'use strict'

angular.module 'meetupApp'
.config ($mdThemingProvider) ->
  $mdThemingProvider.theme('default')
  .primaryPalette('deep-orange')
  .accentPalette('lime')
