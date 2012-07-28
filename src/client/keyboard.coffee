class Keyboard
  @KEYS:
    RETURN: 13
    ESPACE: 32
    SHIFT:  16
    CTRL:   17

    LEFT:   37
    UP:     38
    RIGHT:  39
    DOWN:   40

    A:      65
    D:      68
    W:      87
    S:      83

    NUMBER1:      49
    NUMBER2:      50
    NUMBER3:      51

  constructor: ->
    @keysPressed = []

    $(document).on "keydown", @keyDown
    $(document).on "keyup",   @keyUp

  keyDown: (event) => @keysPressed[event.keyCode] = true
  keyUp:   (event) => @keysPressed[event.keyCode] = false

  isKeyPressed: (keyCode) -> !!@keysPressed[keyCode]

window.Keyboard = Keyboard
