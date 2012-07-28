class WaveManager
  WAVES = [
    [ { amount: 10, enemy: Flyghter } ]
    [ { amount: 15, enemy: Flyghter }, { amount: 10, enemy: Beetlebeer } ]
    [ { amount: 5, enemy: Flyghter }, { amount: 5, enemy: Wespa }, { amount: 10, enemy: Beetlebeer } ]
    [ { amount: 5, enemy: Flyghter }, { amount: 10, enemy: Wespa }, { amount: 10, enemy: Beetlebeer } ]
  ]

  constructor: (@bounds) ->
    @wave = 0
    @availableEnemies = []
    @deployedEnemies = []
    @noobDeployEveryFrame = 120 #frames
    @deployEvery = @noobDeployEveryFrame
    @frame = 0

    do @buildEnemies
    (3).times =>
      do @deployEnemy

  deployPosition: ->
    radomHeight = (@bounds.height / 2) + ([1, -1, 1].sample() * Number.random(@bounds.height / 2))
    radomWidth = (@bounds.width / 2) + ([1, -1, 1].sample() * Number.random(@bounds.width / 2))

    right = [@bounds.width + 100, radomHeight]
    bottom = [radomWidth, @bounds.height + 100]
    left = [-100, radomHeight]

    positions = [right, bottom, left, right]
    position = positions.sample()
    return new Vector position.first(), position.last()

  buildEnemy: (enemy) =>
    @availableEnemies.push new enemy(@deployPosition())

  buildEnemies: ->
    magicNumber = 1
    waves = WAVES[@wave]

    # creating infinite waves
    unless waves
      magicNumber = @wave
      waves = WAVES.sample()

    for wave in waves
      total = wave.amount * magicNumber
      for i in [0...total]
        @buildEnemy wave.enemy

  draw: (context) ->
    for enemy in @deployedEnemies when enemy?
      enemy.draw context

  update: (game) ->
    @frame += 1
    for enemy in @deployedEnemies when enemy?
      enemy.update game

    shouldDeploy = @frame % @deployEvery == 0

    if shouldDeploy or (@availableEnemies.length == 0 and @deployedEnemies.length == 0)
      if @availableEnemies.length > 0
        (@numberOfEnemiesToDeploy()).times @deployEnemy
      else if @deployedEnemies.length == 0
        do @nextWave

  deployEnemy: =>
    if @availableEnemies.length > 0
      index = Number.random @availableEnemies.length - 1
      enemy = @availableEnemies[index]
      @availableEnemies.remove enemy
      @deployedEnemies.push enemy if enemy?

  enemies: ->
    @deployedEnemies

  numberOfEnemiesToDeploy: ->
    amount = [1..@minChanceOfSimultaneousEmenies()]
    amount.push amount.last()
    amount.sample()

  minChanceOfSimultaneousEmenies: ->
    min = Math.round (@wave + 1) * 1.5
    [@availableEnemies.length, min].min()


  nextWave: ->
    @wave +=1
    @deployEvery = Math.round @noobDeployEveryFrame / (@wave * 0.5)
    @deployEvery = 50 if @deployEvery < 50
    do @buildEnemies


window.WaveManager = WaveManager
