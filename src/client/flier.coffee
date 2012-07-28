class Flier
  constructor: (@position = new Vector, @speed = 10) ->
    @velocity     = new Vector
    @acceleration = new Vector
    @force = 1

  applyDirection: (direction) -> @acceleration.add direction.mult(@force)

window.Flier = Flier
