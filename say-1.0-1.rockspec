package = "say"
version = "1.0-1"
source = {
  url = "https://github.com/downloads/Olivine-Labs/say/say-1.0.tar.gz",
  dir = "say"
}
description = {
  summary = "Lua String Hashing/Indexing Library",
  detailed = [[
    Useful for internationalization.
  ]],
  homepage = "http://olivinelabs.com/busted/",
  license = "MIT <http://opensource.org/licenses/MIT>"
}
dependencies = {
  "lua >= 5.1",
  "microlight >= 1.0"
}
build = {
  type = "builtin",
  modules = {
    ["say.s"] = "src/s.lua"
  }
}
