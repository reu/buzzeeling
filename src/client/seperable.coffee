Separable =
  applySeparation: (bees) ->
    force = @separate bees
    force.mult(2)
    @applyForce force

  separate: (bees) ->
    desired = @radius * @approximation
    force = new Vector 0, 0

    count = 0

    for bee in bees when bee != this
      distance = Vector.dist @position, bee.position

      if distance > 0 and distance < desired
        diff = Vector.sub @position, bee.position
        do diff.normalize
        diff.div distance
        force.add diff

        count += 1

    if count > 0
      force.div count
      do force.normalize
      force.mult @maxspeed
      force.sub @velocity
      force.limit @maxforce

    return force

window.Separable = Separable
