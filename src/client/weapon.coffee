class Weapon
  constructor: (@player) ->
    @time = 0
    @canFire = true
    @rateOfFire = 10

  update: ->
    @time += 1
    @canFire = @time % @rateOfFire == 0 or @time == 0

class Pistol extends Weapon
  shot: ->
    bullet = new Bullet @player.position.clone(), @player.angle
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

  update: ->
    @position.add @velocity

  draw: (context) ->
    context.beginPath()
    context.fillStyle = "#fff"
    context.fillCircle @position.x, @position.y, @radius
    context.closePath()

window.Pistol = Pistol
window.DoublePistol = DoublePistol
window.Shotgun = Shotgun
