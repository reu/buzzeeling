class GameAudio
  constructor: ->
    @gamePlay   = new Audio "sounds/gameplay.ogg"
    @gameOver   = new Audio "sounds/gameover.mp3"
    @menu       = new Audio "sounds/menu.ogg"
    @gameStart  = new Audio "sounds/inbass.mp3"
    @splash     = new Audio "sounds/splash.mp3"
    @collision  = new Audio "sounds/collision.ogg"
    @beeShot    = new Audio "sounds/bee_shot.ogg"
    @bee        = new Audio "sounds/bee.mp3"

    ([@gamePlay, @gameOver, @menu, @bee, @gameStart, @collision, @splash, @beeShot]).each (sound) ->
      sound.preload = 'auto'
      # There is no stop in the API
      sound.stop = ->
        do @pause
        @currentTime = 0

    ([@gamePlay, @menu, @bee]).each (sound) -> sound.loop = true

    @bee.volume = 0.4

window.GameAudio = GameAudio
window.AudioManager = new GameAudio
