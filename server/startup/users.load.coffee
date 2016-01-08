Meteor.startup ->
  Users = Meteor.users
  if Meteor.reset
    console.warn 'Users deleted'
    Users.remove({})
  if Users.find().count() == 0
    users = [
      {_id: 'sys', username: '【系统】', password: 'Z1jKa23A!#', profile: face: '/img/avatar/staff_login.png'}
      {_id: 'admin', username: 'admin', password: 'A6d4m3i2n1#', profile: face: '/img/avatar/admin-girl.png'}
    ]
    users.forEach (user) ->
      #Accounts.createUser user
      Users.insert user
      Accounts.setPassword user._id, user.password