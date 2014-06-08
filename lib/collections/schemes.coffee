##############
### global ###
##############
@schemes = new Meteor.Collection "schemes"

##############
### client ###
##############
if Meteor.isClient
  1=1
  # client only

##############
### server ###
##############
if Meteor.isServer
  # server only
  Meteor.publish "schemes", (params) ->
    @ready()
