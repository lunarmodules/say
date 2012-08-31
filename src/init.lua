local s = {
  registry = { },

  set_namespace = function(self, namespace)
    self.current_namespace = namespace
    if not self.registry[self.current_namespace] then
      self.registry[self.current_namespace] = {}
    end
  end,

  set_fallback = function(self, namespace)
    self.fallback_namespace = namespace
    if not self.registry[self.fallback_namespace] then
      self.registry[self.fallback_namespace] = {}
    end
  end,

  set = function(self, key, value)
    self.registry[self.current_namespace][key] = value
  end
}

local __meta = {
  __call = function(self, key, vars)
    vars = vars or {}
    local str = tostring(self.registry[self.current_namespace][key] or self.registry[self.fallback_namespace][key] or '')
    local strings = {}

    for i,v in ipairs(vars) do
      table.insert(strings, tostring(v))
    end

    return #strings > 0 and str:format(unpack(strings)) or str
  end,

  __index = function(self, key)
    return self.registry[key]
  end
}

s:set_fallback('en')
s:set_namespace('en')

return setmetatable(s, __meta)
