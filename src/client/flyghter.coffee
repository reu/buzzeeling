class Flyghter extends Enemy

  constructor: (@position) ->
    @speed = 15
    @hp = 1
    @score = 100
    super @position, @speed, @hp, @score
    @animation = new Animation("flyghter", 8)

window.Flyghter = Flyghter
