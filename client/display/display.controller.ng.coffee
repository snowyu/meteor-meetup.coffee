'use strict'

angular.module 'meetupApp'
.controller 'DisplayCtrl', ($scope, $auth, $state, $window, $mdSidenav, $timeout, $log, $location) ->
  console.log '$auth', $scope.$auth
  currentUser = $scope.$auth.currentUser
  unless currentUser
    $state.go 'register'
    return
  #console.log $location.absUrl('')

  $scope.getFace = (msg) ->
      return unless msg
      result = Meteor.users.findOne(msg.createdBy)
      result = result.profile.face if result
      result

  # mdSidenav
  debounce = (func, wait, context)->
    return ->
      context = $scope
      args = Array.prototype.slice.call(arguments)
      $timeout.cancel(timer)
      fn = ->
        timer = undefined;
        func.apply(context, args);
      timer = $timeout fn, wait || 10
      return

  buildDelayedToggler = (navID)->
    fn = ->
      $mdSidenav(navID)
      .toggle()
      .then ->
        $log.debug("toggle " + navID + " is done")
        return
    debounce fn, 200

  buildToggler = (navID)->
    return ->
      $mdSidenav(navID)
      .toggle()
      .then ->
        $log.debug("toggle " + navID + " is done")
        return

  $scope.toggleRight = buildToggler('navRight')
  $scope.isOpenRight = -> $mdSidenav('navRight').isOpen()

  $scope.fetchUrl = $state.href('activity-fetch', {}, {absolute: true})
  $scope.sort = createdAt : -1

  $scope.helpers
    messages: ->
      Messages.find {}, {sort:$scope.getReactively('sort')}

  # $scope.messages = $scope.$meteorCollection ->
  #   Messages.find {}, {sort:$scope.getReactively('sort')}

  # $meteor.autorun $scope, () ->
  #   $scope.$meteorSubscribe 'messages',
  #     sort: $scope.getReactively('sort')

  # $meteor.session 'messagesCounter'
  # .bind $scope, 'page'

  $scope.helpers
    settings: -> Settings.findOne 'main'
    leftActivities: -> Activities.find(ownedBy: $not: $ne: null).fetch()
    leftCount: -> Activities.find(ownedBy: $not: $ne: null).count()

  # console.log 'fetchEnabled=', $scope.settings.fetchEnabled
  $scope.setFetchEnabled = ->
    #$scope.fetchEnabled = true #!$scope.fetchEnabled
    Settings.update 'main', $set: fetchEnabled: true#$scope.fetchEnabled
    $scope.toggleRight()
    return

  # auto height the messages-container
  # add ng-style="listStyle" to your messages-container
  ###
  $scope.listStyle =
    height: ($window.innerHeight - 112) + 'px'
  $window.addEventListener 'resize', ->
    $scope.listStyle.height = ($window.innerHeight - 112) + 'px';
    if !$scope.$root.$$phase
      $scope.$digest()
    return
  $scope.$on '$destroy', ->
    $window.removeEventListener('resize', onResize)
    return
  ###


  return
