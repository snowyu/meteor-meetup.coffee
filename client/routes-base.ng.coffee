'use strict'

angular.module 'meetupApp'

.config ($urlRouterProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $urlRouterProvider.otherwise '/'

.run ($rootScope, $state) ->
  #$rootScope.currentUser = Meteor.user() # the angular-meteor added.
  console.log 'rootScope', $rootScope.$auth


  $rootScope.updateSetting = ->
    vSettings = $rootScope.settings = Settings.findOne('main')
    if vSettings
      vTitle = vSettings.title
      vSubtitle = vSettings.subtitle
    else
      $rootScope.settings = {}
    unless vTitle
      vTitle = '重庆IoT新年联会'
      $rootScope.settings.title = vTitle
    unless vSubtitle
      vSubtitle = '物联利浪'
      $rootScope.settings.subtitle = vSubtitle
    $rootScope.appName =  vTitle + '-' + vSubtitle #'2016年联会-物联利浪'
    return

  unsubscribe = Meteor.subscribe 'settings', onReady:->
    $rootScope.updateSetting()

  $rootScope.$on '$stateChangeSuccess', (ev, to, toParams, from, fromParams)->
    $rootScope.previousState = from.name
    $rootScope.previousStateParams = fromParams
    $rootScope.currentState = to.name
    console.log('Previous state:'+$rootScope.previousState)
    console.log('Current state:'+$rootScope.currentState)

  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    switch error
      when 'AUTH_REQUIRED', 'FORBIDDEN', 'UNAUTHORIZED'
        $state.go 'messages'
