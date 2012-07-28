class Flyghter extends Enemy

  constructor: (@position) ->
    @speed = 15
    @hp = 3
    super @position, @speed, @hp
    @animation = new Animation("flyghter", 8, 50)

window.Flyghter = Flyghter
