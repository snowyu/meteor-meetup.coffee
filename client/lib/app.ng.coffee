#'angular-meteor.auth'
angular.module 'meetupApp', [
  'angular-meteor'
  'angular-meteor.auth'
  'ui.router'
  'ngMaterial'
  'ngSanitize'
  'accounts.ui'
  'angularMoment'
  'monospaced.qrcode'
  'ngFileUpload'
  'angular-smilies'
]

onReady = () ->
  angular.bootstrap document, ['meetupApp']

if Meteor.isCordova
  angular.element(document).on 'deviceready', onReady
else
  angular.element(document).ready onReady