## unused-activity collection
###
@Unused = new Mongo.Collection('unused')

Unused.allow
  insert: (userId, item) ->
    if userId
      item.createdAt = new Date()
      item.createdBy = userId
    userId
  update: (userId, item, fields, modifier) ->
    if userId
      item.createdAt = new Date()
      item.createdBy = userId
    userId
  remove: (userId, item) ->
    userId
###