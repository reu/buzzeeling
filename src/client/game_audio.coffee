class GameAudio
  constructor: ->
    @gamePlay = new Audio "sounds/gameplay.mp3"
    @gameOver = new Audio "sounds/gameover.mp3"
    @menu     = new Audio "sounds/menu.mp3"
    @bee      = new Audio "sounds/bee.mp3"

    ([@gamePlay, @gameOver, @menu, @bee]).each (sound) ->
      sound.preload = 'auto'
      # There is no stop in the API
      sound.stop = ->
        do @pause
        @currentTime = 0

    ([@gamePlay, @bee]).each (sound) -> sound.loop = true

window.GameAudio = GameAudio
window.AudioManager = new GameAudio
