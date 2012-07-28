class Beetlebeer extends Enemy

  constructor: (@position) ->
    @speed = 5
    @hp = 3
    super @position, @speed, @hp
    @animation = new Animation("beetlebeer", 8, 50)

window.Beetlebeer = Beetlebeer
