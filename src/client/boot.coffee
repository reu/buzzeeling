jQuery ->
  $("img").on "mousedown", (e) -> e.preventDefault()
  $("#game").hide()

  $("#restart").click ->
    $('#gameover').hide()
    $("#game").fadeIn 1000, -> do new Game().start

  $("#play").click ->
    $("#menu").hide()
    $("#game").fadeIn 1000, -> do new Game().start


