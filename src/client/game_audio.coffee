class GameAudio
  constructor: ->
    @gamePlay   = Resources.sounds["gameplay"]
    @gameOver   = Resources.sounds["gameover"]
    @menu       = new Audio "sounds/menu.ogg"
    @gameStart  = new Audio "sounds/inbass.mp3"
    @splash     = Resources.sounds["splash"]
    @collision  = Resources.sounds["collision"]
    @beeShot    = Resources.sounds["bee_shot"]
    @reload     = Resources.sounds["reload"]
    @bee        = Resources.sounds["bee"]
    @yay        = Resources.sounds["yeah"]

    ([@gamePlay, @gameOver, @menu, @bee, @gameStart, @collision, @splash, @beeShot, @reload, @yay]).each (sound) ->
      sound.preload = 'auto'
      # There is no stop in the API
      sound.stop = ->
        do @pause
        @currentTime = 0

    ([@gamePlay, @menu, @bee]).each (sound) -> sound.loop = true

    @bee.volume     = 0.4
    @reload.volume  = 0.4

window.GameAudio = GameAudio
window.AudioManager = new GameAudio
