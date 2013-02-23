
class Lights
  constructor: (@p) ->

  draw: () ->
    @p.ambientLight 90, 90, 90
    @p.directionalLight 51, 0, 126, -1, -1, -0.2
    @p.pointLight 50, 150, 50, 100, 80, 50

################################

class Set
  constructor: (@p) ->

  draw: () ->
    @p.fill 0, 0, 255
    @p.beginShape()
    @p.normal 0, 100, 0
    @p.vertex 100, 0, 100
    @p.vertex -100, 0, 100
    @p.vertex -100, 0, -100
    @p.vertex 100, 0, -100
    @p.endShape()

################################

class Cam
  constructor: (@p) ->
    @x = 0; @y = 20; @z = 200
  draw: () ->
    @p.camera -@x, @y, @z, -@x, @y, 0, 0, -1, 0

################################

class Guy
  constructor: (@p) ->
    @x = 0
    @y = 15
    @z = 0

  draw: (t) ->
    @x = 100 * @p.sin(t / 1000.0)
    @z = 100 * @p.cos(t / 1000.0)
    @p.fill 255, 255, 255
    @p.pushMatrix()
    @p.translate @x, @y, @z
    @p.sphere 15
    @p.popMatrix()

################################

class Box
  constructor: (@p) ->
    @x

################################

coffee_draw = (p) ->
  p.setup = () ->
    @start = now()
    @t = 0
    p.size $('#processing').width(), $('#processing').height(), p.OPENGL
    @set = new Set(p)
    @lights = new Lights(p)
    @cam = new Cam(p)
    @guy = new Guy(p)

  text_sample = ->
    p.ellipse 30, 30, 20, 20
    f = p.createFont "Arial", 24, true
    p.textFont f
    p.text "foobar", 500, 500

    s = "foo, bar, baz, bam"
    x = 30
    for c in s
      p.textSize p.random(12, 36)
      p.text c, x, (p.height / 2)
      x += p.textWidth c
    p.noLoop()

  now = () ->
    (new Date()).getTime()

  p.tick = () ->
    n = now()
    @dt = n - @t - @start
    @t = n - @start


  p.draw = () ->
    p.tick()
    @t = now() - @start
    p.background 0
    p.noStroke()
    @cam.draw()
    @lights.draw()
    @set.draw()
    @guy.draw(@t)

  p.keyPressed = () ->
    console.log p.key
    switch p.key.code
      when 119 then @cam.z -= @dt / 2.0 # w
      when 115 then @cam.z += @dt / 2.0 # s
      when 97  then @cam.x -= @dt / 2.0 # a
      when 100 then @cam.x += @dt / 2.0 # d
      when 101 then @cam.y += @dt / 2.0 # e
      when 99  then @cam.y -= @dt / 2.0 # c


$(document).ready ->
  canvas = document.getElementById "processing"
  processing = new Processing(canvas, coffee_draw)