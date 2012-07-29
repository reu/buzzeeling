class Weapon
  constructor: (@player) ->
    @time = 0
    @canFire = true
    @rateOfFire = 10
    @timeToReload = 40
    @reloadTimer = 0
    @isReloading = false
    @clipSize = 5
    @ammo = @clipSize
    @defaultShotSound = "sounds/bee_shot.ogg"

  shotSound: ->
    @defaultShotSound

  playShot: ->
    shot = new Audio(@shotSound())
    shot.preload = 'auto'
    shot.volume = 0.4
    do shot.play

  shot: ->
    if @canFire
      do @playShot
      do @performShot
    else if @ammo == 0
      do @reload

  performShot: ->
    @ammo -= 1

  reloadStarted: ->
  reloadFinished: ->
  reload: ->
    return if @isReloading

    if !@isReloading and @ammo != @clipSize
      @isReloading = true
      do @reloadStarted

  reloadingLoop: ->
    if @isReloading
      if @reloadTimer >= @timeToReload
        @isReloading = false
        @reloadTimer = 0
        @ammo = @clipSize
        do @reloadFinished
      else
        @reloadTimer += 1

  update: ->
    do @reloadingLoop if @isReloading
    @time += 1
    @canFire = (@time % @rateOfFire == 0 or @time == 0) and !@isReloading and @ammo > 0

  draw: (context) ->

class Pistol extends Weapon
  shot: ->
    bullet = new Bullet @player.position.clone(), @player.angle, 30
    @player.addBullet bullet

class DoublePistol extends Weapon
  constructor: (@player) ->
    super @player
    @rateOfFire = 10
    @lastShot = "left gun"

  shot: ->
    vx = @player.mouse.position.x - @player.position.x
    vy = @player.mouse.position.y - @player.position.y
    normal = new Vector(-vy, vx).normalize()

    if @lastShot is "left gun"
      position = @player.position.clone().add(normal.clone().mult(10))
      @lastShot = "right gun"
    else
      position = @player.position.clone().add(normal.clone().mult(-10))
      @lastShot = "left gun"

    bullet = new Bullet position, @player.angle, 10
    @player.addBullet bullet

class Shotgun extends Weapon
  # TODO: implement reload
  constructor: (@player) ->
    super @player
    @rateOfFire = 20

  shot: ->
    for difference in [-0.2, 0, 0.2]
      bullet = new Bullet @player.position.clone(), @player.angle + difference, 10
      @player.addBullet bullet

class Bullet
  constructor: (@position, angle, speed = 6) ->
    @velocity = Vector.fromAngle(angle)
    @velocity.mult speed
    @radius = 3
    @lastPosition = @position
    @radius = 4
    @damage = 1

  update: ->
    @lastPosition = @position.clone()
    @position.add @velocity


  draw: (context) ->
    context.beginPath()
    context.fillStyle = "#fff"
    context.fillCircle @position.x, @position.y, @radius
    context.closePath()

window.Bullet = Bullet
window.Weapon = Weapon
window.Pistol = Pistol
window.DoublePistol = DoublePistol
window.Shotgun = Shotgun
