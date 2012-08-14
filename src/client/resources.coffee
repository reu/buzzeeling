class ResourceManager
  IMAGES = [
    "battrick1.png"
    "battrick2.png"
    "battrick3.png"
    "battrick4.png"
    "battrick5.png"
    "battrick6.png"
    "battrick7.png"
    "battrick8.png"
    "beetlebeer1.png"
    "beetlebeer2.png"
    "beetlebeer3.png"
    "beetlebeer4.png"
    "beetlebeer5.png"
    "beetlebeer6.png"
    "beetlebeer7.png"
    "beetlebeer8.png"
    "beezerk1.png"
    "beezerk2.png"
    "beezerk3.png"
    "beezerk4.png"
    "beezerk5.png"
    "beezerk6.png"
    "beezerk7.png"
    "beezerk8.png"
    "colmeia0.png"
    "colmeia1.png"
    "colmeia10.png"
    "colmeia2.png"
    "colmeia3.png"
    "colmeia4.png"
    "colmeia5.png"
    "colmeia6.png"
    "colmeia7.png"
    "colmeia8.png"
    "colmeia9.png"
    "duif1.png"
    "duif2.png"
    "duif3.png"
    "duif4.png"
    "duif5.png"
    "duif6.png"
    "duif7.png"
    "duif8.png"
    "flyghter1.png"
    "flyghter2.png"
    "flyghter3.png"
    "flyghter4.png"
    "flyghter5.png"
    "flyghter6.png"
    "flyghter7.png"
    "flyghter8.png"
    "fundo_colmeia.png"
    "galho.png"
    "game-over.jpg"
    "giuffrida1.png"
    "giuffrida2.png"
    "giuffrida3.png"
    "giuffrida4.png"
    "giuffrida5.png"
    "giuffrida6.png"
    "giuffrida7.png"
    "giuffrida8.png"
    "hit.png"
    "mel1.png"
    "mel2.png"
    "mel3.png"
    "mel4.png"
    "mel5.png"
    "mel6.png"
    "mel7.png"
    "mel8.png"
    "minibee1.png"
    "minibee2.png"
    "minibee3.png"
    "minibee4.png"
    "minibee5.png"
    "minibee6.png"
    "minibee7.png"
    "minibee8.png"
    "minibee_attacking1.png"
    "score.png"
    "splash1.png"
    "splash2.png"
    "splash3.png"
    "splash4.png"
    "splash5.png"
    "splash6.png"
    "splash7.png"
    "splash8.png"
    "target1.png"
    "wespa1.png"
    "wespa2.png"
    "wespa3.png"
    "wespa4.png"
    "wespa5.png"
    "wespa6.png"
    "wespa7.png"
    "wespa8.png"
  ]

  SOUNDS = [
    "bee.mp3"
    "bee_shot.ogg"
    "collision.ogg"
    "gameover.mp3"
    "gameplay.ogg"
    "hive_collision.ogg"
    "inbass.mp3"
    "menu.ogg"
    "reload.ogg"
    "splash.mp3"
    "wee.ogg"
    "yeah.ogg"
  ]

  constructor: ->
    @images = {}
    @sounds = {}

  load: (callback) ->
    loaded = 0
    resourcesCount = IMAGES.length + SOUNDS.length
    resourceLoaded = ->
      loaded += 1
      console.log "#{loaded / resourcesCount * 100}%"
      do callback if loaded == resourcesCount

    for image in IMAGES
      src = "images/#{image}"
      image = new Image
      image.onload = resourceLoaded
      image.src = src
      name = src.replace("images/", "").replace(/\.\w+$/, "")
      @images[name] = image

    for sound in SOUNDS
      src = "sounds/#{sound}"
      sound = new Audio
      sound.onload = resourceLoaded
      sound.src = src
      name = src.replace("sounds/", "").replace(/\.\w+$/, "")
      @sounds[src.replace(/\.\w+$/, "")] = sound

window.Resources = new ResourceManager
