class @timelineGrid
  constructor: (args) ->
    @options  = args

    throw "you must pass seconds" if !@options.seconds?
    throw "you must pass pps" if !@options.pps?

    @retina                 = window.devicePixelRatio or 1

    @options.horzPadding    = 20 * @retina
    @options.vertPadding    = 20 * @retina

    @options.appendTo       = @options.appendTo or document.body

    @options.markerInterval = @options.markerInterval * @retina or 7.5 * @retina
    @options.pps            = @options.pps * @retina

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

  draw: ->
    lineWidth   = 4

    o = @options # just a short hand for this fun

    for i in [0 .. o.seconds - 1] by 0.5
      h = if i % 1 then (o.height - o.vertPadding)/2 else o.height - o.vertPadding
      x = i * o.pps + lineWidth/2 + o.horzPadding
      y = o.height - h + o.horzPadding

      @ctx.rect x,
                o.height - h,
                lineWidth,
                h

    @ctx.fill()
