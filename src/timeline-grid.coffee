class @timelineGrid
  constructor: (args) ->
    @options  = args

    throw "you must pass seconds" if !@options.seconds?
    throw "you must pass pps" if !@options.pps?

    @retina                 = window.devicePixelRatio or 1

    @options.horzPadding    = 20 * @retina
    @options.vertPadding    = 20 * @retina

    @options.appendTo       = @options.appendTo or document.body

    @options.pps            = @options.pps * @retina

    @options.lineWidth      = @options.lineWidth or 4
    @options.fontStyle      = @options.fontStyle or '15px Helvetica'
    @options.fillStyle      = @options.fillStyle or "black"

    @options.height         = (@options.height * @retina or 50 * @retina) + @options.vertPadding
    @options.width          = @options.seconds * @options.pps + @options.horzPadding

    @canvas                 = document.createElement 'canvas'

    @canvas.setAttribute 'width', @options.width
    @canvas.setAttribute 'height', @options.height

    @canvas.style.width  = "#{@options.width / @retina}px"
    @canvas.style.height = "#{@options.height / @retina}px"

    @ctx      = @canvas.getContext '2d'
    @options.appendTo.appendChild @canvas
    @draw()

  formatTime: (second) ->
    min     = ~~(second/60)
    tenM    = ~~(min/10)
    oneM    = ~~(min/10 % 1 * 10)
    seconds = if (""+(second%60)).length == 1 then "0"+second%60 else second%60

    "#{tenM}#{oneM}:#{seconds}"

  draw: ->
    o = @options # just a short hand for this fun
    @ctx.font       = o.fontStyle
    @ctx.fillStyle  = o.fillStyle

    for i in [0 .. o.seconds - 1] by 0.5
      h = if i % 1 then (o.height - o.vertPadding)/2 else o.height - o.vertPadding
      x = i * o.pps + o.lineWidth/2 + o.horzPadding
      y = o.height - h + o.horzPadding

      if !(i % 1)
        timeStamp = @formatTime(i+1)
        metrics   = @ctx.measureText timeStamp #textwidth
        @ctx.fillText @formatTime(i+1),
                      x - metrics.width/2 + o.lineWidth/2,
                      @options.vertPadding / 2

      @ctx.rect x,
                o.height - h,
                o.lineWidth,
                h

    @ctx.fill()
