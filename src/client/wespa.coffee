class Wespa extends Enemy

  constructor: (@position) ->
    @speed = 10
    @hp = 3
    super @position, @speed, @hp
    @animation = new Animation("wespa", 8, 60)

window.Wespa = Wespa
