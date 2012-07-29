class Duif extends Enemy

  constructor: (@position) ->
    @speed = 4
    @hp = 8
    @score = 500
    super @position, @speed, @hp, @score
    @animation = new Animation("duif", 8)

window.Duif = Duif
