class Beetlebeer extends Enemy

  constructor: (@position) ->
    @speed = 5
    @hp = 5
    super @position, @speed, @hp
    @animation = new Animation("beetlebeer", 8)

window.Beetlebeer = Beetlebeer
