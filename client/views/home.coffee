Template.home.rendered ->
  # store the initial angles
  # change the value function
  # compute the new angles
  # redraw the arcs
  type = (d) ->
    d.apples = +d.apples or 0
    d.oranges = +d.oranges or 0
    d

  # Store the displayed angles in _current.
  # Then, interpolate from _current to the new angles.
  # During the transition, _current is updated in-place by d3.interpolate.
  arcTween = (a) ->
    i = d3.interpolate(@_current, a)
    @_current = i(0)
    (t) ->
      arc i(t)
  width = 960
  height = 500
  radius = Math.min(width, height) / 2
  color = d3.scale.category20()
  pie = d3.layout.pie().value((d) ->
    d.apples
  ).sort(null)
  arc = d3.svg.arc().innerRadius(radius - 100).outerRadius(radius - 20)
  svg = d3.select("body").append("svg").attr("width", width).attr("height", height).append("g").attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
  d3.tsv "data.tsv", type, (error, data) ->
    change = ->
      value = @value
      clearTimeout timeout
      pie.value (d) ->
        d[value]

      path = path.data(pie)
      path.transition().duration(750).attrTween "d", arcTween
      return
    path = svg.datum(data).selectAll("path").data(pie).enter().append("path").attr("fill", (d, i) ->
      color i
    ).attr("d", arc).each((d) ->
      @_current = d
      return
    )
    d3.selectAll("input").on "change", change
    timeout = setTimeout(->
      d3.select("input[value=\"oranges\"]").property("checked", true).each change
      return
    , 2000)
    return
