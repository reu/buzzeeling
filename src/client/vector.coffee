class Vector
  constructor: (@x = 0, @y = 0, @z = 0) ->

  add: (vector) ->
    @x += vector.x
    @y += vector.y
    @z += vector.z
    this

  @add: (v1, v2) ->
    new Vector v1.x + v2.x, v1.y + v2.y, v1.z + v2.z

  sub: (vector) ->
    @x -= vector.x
    @y -= vector.y
    @z -= vector.z
    this

  @sub: (v1, v2) ->
    new Vector v1.x - v2.x, v1.y - v2.y, v1.z - v2.z

  mult: (scalar) ->
    @x *= scalar
    @y *= scalar
    @z *= scalar
    this

  @mult: (vector, scalar) ->
    new Vector vector.x * scalar, vector.y * scalar, vector.z * scalar

  div: (scalar) ->
    @x /= scalar
    @y /= scalar
    @z /= scalar
    this

  @div: (vector, scalar) ->
    new Vector vector.x / scalar, vector.y / scalar, vector.z / scalar

  magSq: ->
    @x * @x + @y * @y + @z * @z

  mag: ->
    Math.sqrt @magSq()

  normalize: ->
    @div(@mag())

  limit: (max) ->
    do @normalize and @mult(max) if @mag() > max

  dot: (vector) ->
    @x * vector.x + @y * vector.y + @z * vector.z

  @dot: (v1, v2) ->
    v1.x * v2.x + v1.y * v2.y + v1.z * v2.z

  distance: (vector) ->
    dx = @x - vector.x
    dy = @y - vector.y
    dz = @z - vector.z

    Math.sqrt dx*dx + dy*dy + dz*dz

  @distance: (v1, v2) ->
    dx = v1.x - v2.x
    dy = v1.y - v2.y
    dz = v1.z - v2.z

    Math.sqrt dx*dx + dy*dy + dz*dz

  clone: ->
    new Vector @x, @y, @z

  @angleBetween: (v1, v2) ->
    amt = Vector.dot(v1, v2) / v1.mag() * v2.mag()

    if amt < -1
      Math.PI
    else if amt >= 1
      0
    else
      Math.acos(amt)

  @fromAngle: (angle) ->
    new Vector Math.cos(angle), Math.sin(angle)

  toString: ->
    "(#{[@x, @y, @z].join(", ")})"

  @dist: (v1, v2) ->
    dx = v1.x - v2.x
    dy = v1.y - v2.y
    dz = v1.z - v2.z

    Math.sqrt dx * dx + dy * dy + dz * dz

window.Vector = Vector
