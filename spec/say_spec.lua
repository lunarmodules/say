local s

describe("Tests to make sure the say library is functional", function()
  setup(function()
    package.loaded['say'] = false -- busted uses it, must force to reload
    s = require('init')   -- devcode is in /src/init.lua not in /src/say/init.lua
  end)
  
  it("tests the set function metamethod", function()
    s:set('herp', 'derp')
    assert(s._registry.en.herp == 'derp')
  end)

  it("tests the __call metamethod", function()
    s:set('herp', 'derp')
    assert(s('herp') == 'derp')

    s:set('herp', '%s')
    assert(s('herp', {'test'}) == 'test')

    s:set('herp', '%s%s')
    assert(s('herp', {'test', 'test'}) == 'testtest')
  end)

  it("tests the substitution of variable types; boolean, number, string and table", function()
    s:set('substitute_test', 'boolean = %s, number = %s, string = "%s", table = %s')
    local atable = {}
    assert(s('substitute_test', {true, 100, 'some text', atable}) == 'boolean = true, number = 100, string = "some text", table = ' .. tostring(atable))
  end)

  it("tests the set_fallback method", function()
    s:set_namespace('en')
    s:set('herp', 'derp')
    s:set_namespace('not-en')
    s:set('not-herp', 'not-derp')

    assert(s('not-herp') == 'not-derp')    
    assert(s('herp') == 'derp')
  end)

  it("tests missing elements returns nil", function()
    assert(s('this does not exist') == nil)
  end)
end)
