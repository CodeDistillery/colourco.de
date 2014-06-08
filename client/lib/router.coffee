requireLogin = ->
  if not Meteor.user()
    if Meteor.loggingIn()
      @render @loadingTemplate
    else
       Router.go "signin"
    @stop()

Router.configure
  layoutTemplate: "layout-default"

Router.before () ->
  params = {}
  for key, value of @params
    params[key] = value if value?
  Session.set "params", params
  return

###
Router.before requireLogin,
  except: [
    "app"
  ]
###

Router.map ->
  #Promo
  @route "home",
    path: "/"
  @route "app",
    path: "/app/:scheme/:mode/:type/:c0?/:c1?/:c2?/:c3?/:c4?/:c5?/:c6?/:c7?/:c8?/:c9?"
