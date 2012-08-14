jQuery ->
  do AudioManager.menu.play

  $("img").on "mousedown", (e) -> e.preventDefault()
  $("#game").hide()
  $("#us-screen").hide()
  $("#instruction-screen").hide()


  $("#restart").click ->
    do AudioManager.gameStart.play
    $('#gameover').hide()
    $("#game").fadeIn 1000, -> do new Game().start

  $("#play").click ->
    $("#menu").fadeOut 700, ->
      do AudioManager.menu.stop
      do AudioManager.gameStart.play
      $("#game").fadeIn 700, -> do new Game().load

  $('#instruction').click ->
    $("#menu").fadeOut 500, ->
      $("#instruction-screen").fadeIn 500

  $('#us').click ->
    $("#menu").fadeOut 500, ->
      $("#us-screen").fadeIn 500

  $('#back-to-menu-from-instruction').click ->
    $("#instruction-screen").fadeOut 500, ->
      $("#menu").fadeIn 500

  $('#back-to-menu-from-us').click ->
    $("#us-screen").fadeOut 500, ->
      $("#menu").fadeIn 500
