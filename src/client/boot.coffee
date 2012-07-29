jQuery ->
  do AudioManager.menu.play

  $("img").on "mousedown", (e) -> e.preventDefault()
  $("#game").hide()

  $("#restart").click ->
    $('#gameover').hide()
    $("#game").fadeIn 1000, -> do new Game().start

  $("#play").click ->
    $("#menu").hide()
    do AudioManager.menu.stop
    $("#game").fadeIn 1000, -> do new Game().start


