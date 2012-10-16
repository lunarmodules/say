package = "say"
version = "1.2-1"
source = {
  url = "https://github.com/downloads/Olivine-Labs/say/say-1.2.tar.gz",
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
  "lua >= 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["say.init"] = "src/init.lua"
  }
}
