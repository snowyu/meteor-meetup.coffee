'use strict'

angular.module 'meetupApp'
.directive 'toolbar', ->
  restrict: 'AE'
  templateUrl: 'client/components/toolbar/toolbar.view.html'
  replace: true
 