jQuery ->
  $("img").on "mousedown", (e) -> e.preventDefault()
  $("#game").hide()

  $("#play").click ->
    $("#menu").hide()
    $("#game").fadeIn 1000, ->
      game = new Game
      do game.start


