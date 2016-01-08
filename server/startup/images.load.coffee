# Meteor.startup ->
#   if Images.find().count() == 0
#     images = [
#       {
#         'name': 'image 1'
#       }
#       {
#         'name': 'image 2'
#       }
#     ]
#     images.forEach (image) ->
#       Images.insert image