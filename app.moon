lapis = require "lapis"

import Users from require "models"

import generate_csrf from require "helpers.csrf"

class extends lapis.Application
  layout: require "views.layout"

  @enable "exception_tracking"

  @include "applications.users"
  @include "applications.streaks"
  @include "applications.submissions"
  @include "applications.uploads"

  @before_filter =>
    @current_user = Users\read_session @
    generate_csrf @

    if @current_user
      @current_user\update_last_active!

    if @session.flash
      @flash = @session.flash
      @session.flash = false

  [index: "/"]: =>
    render: true

  [terms: "/terms"]: =>
