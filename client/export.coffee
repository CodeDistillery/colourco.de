getFileName = (colors, extension) ->
  if colors?
    return "color-#{colors[0]}#{extension}" if colors.length is 1
    return "colorscheme-#{colors[2]}#{extension}" if colors.length is 5
  return "colorscheme#{extension}"

getTextDataUrl = (text) ->
  URL = window.webkitURL or window.URL
  BlobBuilder = window.BlobBuilder or window.WebKitBlobBuilder or window.MozBlobBuilder
  if BlobBuilder?
    bb = new BlobBuilder()
    bb.append text 
    blob = bb.getBlob("text/plain")
  else
    blob = new Blob([text])
  URL.createObjectURL blob

getImageDataUrl = (colors) ->
  tileSize = 25
  canvas = document.createElement "canvas"
  canvas.height = tileSize
  canvas.width = tileSize * colors.length
  ctx = canvas.getContext "2d"
  for color, i in colors
    ctx.fillStyle = color
    ctx.fillRect tileSize * i, 0, tileSize * (i + 1), tileSize
  canvas.toDataURL()

@setPngExport = (a) ->
  colors = a.dataset.colors.split ";"
  a.download = getFileName colors, ".png"
  a.href = getImageDataUrl colors

@setLessExport = (a) ->
  colors = a.dataset.colors.split ";"
  colorsFore = a.dataset.colorsfore.split ";"
  a.download = getFileName colors, ".less"
  text = ""
  for color, i in colors
    index = ""
    index = i + 1 if colors.length > 1
    text += "@colorBack#{index}: #{color};\n"
  for colorFore, j in colorsFore
    _index = ""
    _index = j + 1 if colorsFore.length > 1
    text += "@colorFore#{_index}: #{colorFore};\n"
  a.href = getTextDataUrl text

@setSassExport = (a) ->
  colors = a.dataset.colors.split ";"
  a.download = getFileName colors, ".scss"
  text = ""
  for color, i in colors
    index = ""
    index = i + 1 if colors.length > 1
    text += "$color#{index}: #{color};\n"
  a.href = getTextDataUrl text
