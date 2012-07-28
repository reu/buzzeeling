random = (min, max) -> Math.random() * (max - min) + min

class BeeLauncher extends Weapon
  constructor: (@player) ->
    super @player
    @army = []
    for index in [1..25]
      @army.push @generateBee()

  shot: ->
    miniBee = do @consumeBee
    # TODO: nao é o player.angle, teriamos que calcular o angulo aqui
    bullet = new BeeBullet miniBee.position.clone(), @player.angle, 20
    @player.addBullet bullet

  generateBee: ->
    position = new Vector 1024 / 2, 768 / 2
    new MiniBee(position)

  consumeBee: ->
    bee = @army.shift()
    @army.push @generateBee()
    bee

  update: ->
    super

    for bee in @army when bee?
      bee.applySeparation @army
      bee.applySeek @player.position
      do bee.update

  draw: (context) ->
    for bee in @army
      bee.draw context

class MiniBee
  constructor: (@position) ->
    @acceleration = new Vector 0, 0
    @velocity     = new Vector 0, 0

    @radius   = 5
    @maxspeed = 15
    @maxforce = 0.9
    @approximation = 5

  approximate: => if @approximation < 4 then @approximation = 4 else @approximation -= 0.6
  spread:      => if @approximation > 8 then @approximation = 8 else @approximation += 0.2

  applyForce: (force) -> @acceleration.add force

  applySeparation: (bees) ->
    force = @separate bees
    force.mult(2)
    @applyForce force

  applySeek: (target) ->
    force = @seek target
    @applyForce force

  seek: (target) ->
    desired = Vector.sub target, @position

    desired.normalize()
    desired.mult(@maxspeed)

    steering = Vector.sub desired, @velocity
    steering.limit(@maxforce)

    steering

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

  update: ->
    @velocity.add @acceleration
    @velocity.limit @maxspeed
    @position.add @velocity
    @acceleration = new Vector(0, 0)

  draw: (context) ->
    do context.save
    context.fillStyle = "#FFE92B"
    context.strokeStyle = "#000"
    context.ellipse @position.x, @position.y, 10, 6
    do context.stroke
    do context.fill
    do context.restore

class BeeBullet extends Bullet
  draw: (context) ->
    do context.save
    context.fillStyle = "#FFE92B"
    context.strokeStyle = "#000"
    context.ellipse @position.x, @position.y, 10, 6
    do context.stroke
    do context.fill
    do context.restore

window.BeeLauncher = BeeLauncher
