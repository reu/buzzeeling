class GameAudio
  constructor: ->
    @gamePlay   = new Audio "sounds/gameplay.mp3"
    @gameOver   = new Audio "sounds/gameover.mp3"
    @menu       = new Audio "sounds/menu.mp3"
    @gameStart  = new Audio "sounds/inbass.mp3"
    @splash     = new Audio "sounds/splash.mp3"
    @bee        = new Audio "sounds/bee.mp3"

    ([@gamePlay, @gameOver, @menu, @bee, @gameStart]).each (sound) ->
      sound.preload = 'auto'
      # There is no stop in the API
      sound.stop = ->
        do @pause
        @currentTime = 0

    ([@gamePlay, @menu, @bee]).each (sound) -> sound.loop = true

    @bee.volume = 0.3

window.GameAudio = GameAudio
window.AudioManager = new GameAudio
