class Beetlebeer extends Enemy

  constructor: (@position) ->
    @speed = 5
    @hp = 5
    @score = 500
    super @position, @speed, @hp, @score
    @animation = new Animation("beetlebeer", 8)

window.Beetlebeer = Beetlebeer
