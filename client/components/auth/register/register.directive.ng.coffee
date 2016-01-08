'use strict'

angular.module 'meetupApp'
.directive 'register', ->
  restrict: 'E'
  templateUrl: 'client/components/auth/register/register.view.html'
  controllerAs: 'register'
  bindToController: true
  controller: ($scope, $reactive, $state)->
    $reactive(this).attach($scope);
    lastState = $scope.previousState || 'messages'

    @credentials =
      username: ''
      password: ''

    @error = ''
    @register = =>
      @credentials.password = @credentials.phone
      @credentials.profile =
        name: @credentials.username
        company: @credentials.company
      @credentials.profile.phone = @credentials.phone unless isNaN @credentials.phone
      @credentials.username = @credentials.username + '-' + @credentials.company if @credentials.company
      Meteor.loginWithPassword @credentials.username, @credentials.password, (err)=>
        if (err)
          console.log 'login error:', err
          @error = err
          @credentials.profile.face = '/img/avatar/0.jpg' unless @credentials.profile.face
          Accounts.createUser @credentials, (err) =>
            if (err)
              console.log 'register error:', err
              @error = err
            else
              $state.go lastState
        else
          $state.go lastState

    return
