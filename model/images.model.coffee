@Images = new FS.Collection "images",
  stores: [
    new FS.Store.FileSystem "images" #, path: "~/app-files/images"
  ]
  filter:
    allow:
      contentTypes: ['image/*']

Images.allow
  insert: (userId, image) ->
    userId
  update: (userId, image, fields, modifier) ->
    userId
  remove: (userId, image) ->
    userId
  download: ->
    true
