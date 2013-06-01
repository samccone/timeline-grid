(function() {
  this.timelineGrid = (function() {
    function timelineGrid(args) {
      this.options = args;
      if (this.options.seconds == null) {
        throw "you must pass seconds";
      }
      if (this.options.pps == null) {
        throw "you must pass pps";
      }
      this.retina = window.devicePixelRatio || 1;
      this.options.horzPadding = 20 * this.retina;
      this.options.vertPadding = 20 * this.retina;
      this.options.appendTo = this.options.appendTo || document.body;
      this.options.markerInterval = this.options.markerInterval * this.retina || 7.5 * this.retina;
      this.options.pps = this.options.pps * this.retina;
      this.options.height = (this.options.height * this.retina || 50 * this.retina) + this.options.vertPadding;
      this.options.width = this.options.seconds * this.options.pps + this.options.horzPadding;
      this.canvas = document.createElement('canvas');
      this.canvas.setAttribute('width', this.options.width);
      this.canvas.setAttribute('height', this.options.height);
      this.canvas.style.width = "" + (this.options.width / this.retina) + "px";
      this.canvas.style.height = "" + (this.options.height / this.retina) + "px";
      this.ctx = this.canvas.getContext('2d');
      this.options.appendTo.appendChild(this.canvas);
      this.draw();
    }

    timelineGrid.prototype.draw = function() {
      var h, i, lineWidth, o, x, y, _i, _ref;

      lineWidth = 4;
      o = this.options;
      for (i = _i = 0, _ref = o.seconds - 1; 0.5 > 0 ? _i <= _ref : _i >= _ref; i = _i += 0.5) {
        h = i % 1 ? (o.height - o.vertPadding) / 2 : o.height - o.vertPadding;
        x = i * o.pps + lineWidth / 2 + o.horzPadding;
        y = o.height - h + o.horzPadding;
        this.ctx.rect(x, o.height - h, lineWidth, h);
      }
      return this.ctx.fill();
    };

    return timelineGrid;

  })();

}).call(this);
