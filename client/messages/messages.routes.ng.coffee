'use strict'

angular.module 'meetupApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'messages',
    url: '/'
    templateUrl: 'client/messages/messages-list.view.html'
    controller: 'MessagesListCtrl'
    resolve:
      currentUser: ($auth) ->
        $auth.waitForUser()
        # $meteor.waitForUser()

  .state 'message-detail',
    url: '/messages/:messageId'
    templateUrl: 'client/messages/message-detail.view.html'
    controller: 'MessageDetailCtrl'
