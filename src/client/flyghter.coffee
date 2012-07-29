class Flyghter extends Enemy

  constructor: (@position) ->
    @speed = 15
    @hp = 1
    @score = 100
    super @position, @speed, @hp, @score
    @animation = new Animation("flyghter", 8)
    @offset = { x: 22, y: 25 }
    @radius = 10

window.Flyghter = Flyghter
