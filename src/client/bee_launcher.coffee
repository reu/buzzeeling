class BeeLauncher extends Weapon
  constructor: (@player) ->
    super @player
    @army = []
    @size = 10
    for index in [1..@size]
      @army.push @generateBee()
    @isReloading = false
    @reloadTime = 40
    @timer = 0
    @startTime = 0

  shot: ->
    unless @isReloading
      miniBee = do @consumeBee
      # TODO: nao é o player.angle, teriamos que calcular o angulo aqui
      bullet = new BeeBullet miniBee.position.clone(), @player.angle, 20
      @player.addBullet bullet

  generateBee: ->
    position = new Vector 1024 / 2, 768 / 2
    new MiniBee(position)

  reload: ->
    @isReloading = true

    if (@startTime + @reloadTime) <= @timer
      for index in [1..@size]
        @army.push @generateBee()
      @isReloading = false
      @timer = 0

  consumeBee: ->
    bee = @army.shift()
    bee

  update: ->
    super

    for bee in @army when bee?
      bee.applySeparation @army
      bee.applySeek @player.position
      do bee.update

    if @army.length == 0
      @timer += 1
      @reload()

    @startTime = @timer unless @isReloading
    @reload() if @isReloading


  draw: (context) ->
    for bee in @army
      bee.draw context

class MiniBee extends Module
  @include Separable
  @include Seekable

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
