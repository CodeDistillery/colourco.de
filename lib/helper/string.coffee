String::startsWith = (m) -> @match("^#{m}")?
String::endsWith   = (m) -> @match("#{m}$")?
String::contains   = (m) -> @match("#{m}")?
String::data       = -> if @toString() is "" then null else @toString()
String::capitalize = -> if @length > 0 then @[0].toUpperCase() + @slice(1) else ""
