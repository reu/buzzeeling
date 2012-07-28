jQuery ->
  $("img").on "mousedown", (e) -> e.preventDefault()

  game = new Game
  do game.start
