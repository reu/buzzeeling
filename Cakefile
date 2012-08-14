fs     = require "fs"
wrench = require "wrench"

{exec, spawn} = require "child_process"

files = [
  "vector"
  "canvas_extensions"
  "request_animation_frame"
  "module"
  "keyboard"
  "animation"
  "mouse"
  "resources"
  "game_audio"
  "hit"
  "beezerk"
  "splash"
  "honey"
  "hive"
  "weapon"
  "seekable"
  "separable"
  "bee_launcher"
  "flier"
  "bee"
  "enemy"
  "flyghter"
  "beetlebeer"
  "wespa"
  "duif"
  "battrick"
  "score"
  "wave_manager"
  "game"
  "boot"
]

fileList = for file in files
  "src/client/#{file}.coffee"

task "watch", "Generate the javascript output when changes are detected", ->
  fs.unlink "build/views", (error) ->
    wrench.rmdirSyncRecursive "build/views/", true if error
    fs.symlinkSync "#{__dirname}/src/server/views/", "#{__dirname}/build/views"

    watch = exec "coffee -j build/public/javascripts/client.js -cw #{fileList.join(" ")}"
    watch.stdout.on "data", (data) -> process.stdout.write data

    watch = exec "coffee -j build/server.js -cwb src/server/"
    watch.stdout.on "data", (data) -> process.stdout.write data

task "build", "Compiles and minifies everything", ->
  exec "coffee -j build/server.js -cb src/server/", ->
    fs.unlink "build/views", ->
      viewsDir = "#{__dirname}/src/server/views/"
      buildDir = "#{__dirname}/build/views"
      wrench.copyDirSyncRecursive viewsDir, buildDir

  exec "coffee -j build/public/javascripts/client.js -c #{fileList.join(" ")}"
