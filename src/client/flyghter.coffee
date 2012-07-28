class Flyghter extends Enemy

  constructor: (@position) ->
    @speed = 15
    @hp = 1
    super @position, @speed, @hp
    @animation = new Animation("flyghter", 8)

window.Flyghter = Flyghter
