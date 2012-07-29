jQuery ->
  do AudioManager.menu.play

  $("img").on "mousedown", (e) -> e.preventDefault()
  $("#game").hide()

  $("#restart").click ->
    do AudioManager.gameStart.play
    $('#gameover').hide()
    $("#game").fadeIn 1000, -> do new Game().start

  $("#play").click ->
    do AudioManager.gameStart.play
    $("#menu").hide()
    do AudioManager.menu.stop
    $("#game").fadeIn 1000, -> do new Game().start


