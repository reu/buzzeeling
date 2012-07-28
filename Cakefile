fs     = require "fs"
wrench = require "wrench"

{exec, spawn} = require "child_process"

task "watch", "Generate the javascript output when changes are detected", ->
  fs.unlink "build/views", (error) ->
    wrench.rmdirSyncRecursive "build/views/", true if error
    fs.symlinkSync "#{__dirname}/src/server/views/", "#{__dirname}/build/views"

    watch = exec "coffee -o build/public/javascripts/ -cw src/client/"
    watch.stdout.on "data", (data) -> process.stdout.write data

    watch = exec "coffee -j build/server.js -cwb src/server/"
    watch.stdout.on "data", (data) -> process.stdout.write data

task "build", "Compiles and minifies everything", ->
  exec "coffee -j build/server.js -cb src/server/", ->
    fs.unlink "build/views", ->
      viewsDir = "#{__dirname}/src/server/views/"
      buildDir = "#{__dirname}/build/views"
      wrench.copyDirSyncRecursive viewsDir, buildDir

  exec "coffee -o build/public/javascripts/ -c src/client/"
