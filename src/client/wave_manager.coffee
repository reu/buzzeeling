class WaveManager
  WAVES = [
    [ { amount: 10, enemy: Flyghter } ],
    [ { amount: 15, enemy: Flyghter }, { amount: 10, enemy: Flyghter } ]
  ]

  constructor: (@bounds) ->
    @start = new Date
    @wave = 0
    @availableEnemies = []
    @deployedEnemies = []
    @deployEvery = 30 #seconds

    do @buildEnemies
    (3).times =>
      do @deployEnemy

  # Random positions to deploy enemies [[random height], [random width]]
  deployPosition: ->
    randomHeight = [@bounds.width + 100, (@bounds.height / 2) + ([1, -1, 1].sample() * Number.random(@bounds.height / 2))]
    randomWidth = [(@bounds.width / 2) + ([1, -1, 1].sample() * Number.random(@bounds.width / 2)), @bounds.height + 100]
    positions = [randomHeight, randomWidth, randomHeight]
    position = positions.sample()
    return new Vector position.first(), position.last()

  buildEnemy: (enemy) =>
    @availableEnemies.push new enemy(@deployPosition())

  buildEnemies: ->
    for wave in WAVES[@wave]
      for i in [0..wave.amount]
        @buildEnemy wave.enemy

  draw: (context) ->
    for enemy in @deployedEnemies when enemy?
      enemy.draw context

  update: (game) ->
    for enemy in @deployedEnemies when enemy?
      enemy.update game

    now = new Date
    shouldDeploy = Math.round(((now - @start) / 1000) / 60) % @deployEvery == 0

    if shouldDeploy
      if @availableEnemies.length > 0
        numberOfEnemies = [1..[@availableEnemies.length, 2].min()].sample()
        (numberOfEnemies).times @deployEnemy
      else
        #do @nextWave

  deployEnemy: =>
    enemy = @availableEnemies.pop()
    @deployedEnemies.push enemy if enemy?

  enemies: ->
    @deployedEnemies

  nextWave: ->
    @wave +=1
    do @buildEnemies


window.WaveManager = WaveManager
