'use strict'

angular.module 'meetupApp'
.controller 'MessagesListCtrl', ($scope, $meteor, $state, $window, $auth, currentUser) ->
  # the currentUser inject via waitFor in messages.routes.ng.coffee
  console.log 'currentUser', currentUser
  #console.log '$auth.currentUser', $scope.$auth
  unless currentUser
    $state.go 'register'
    return

  $scope.getFace = (msg) ->
      return unless msg
      result = Meteor.users.findOne(msg.createdBy)
      result = result.profile.face if result
      result

  $scope.sort = createdAt : -1
  $scope.messages = $scope.$meteorCollection ->
    Messages.find {}, {sort:$scope.getReactively('sort')}
  #$scope.messages = $scope.$meteorCollection Messages
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe 'messages',
      sort: $scope.getReactively('sort')

  $meteor.session 'messagesCounter'
  .bind $scope, 'page'

  $scope.save = () ->
    if $scope.frmSendMessage.$valid
      $scope.messages.save $scope.newMessage
      $scope.newMessage = undefined

  $scope.remove = (message) ->
    $scope.messages.remove message

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
