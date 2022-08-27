local s

describe("Tests to make sure the say library is functional", function()

  setup(function()
    -- busted loads say internally, force reload in case the sources we're
    -- expected to test (via LUA_PATH) aren't the ones busted found earlier
    package.loaded['say'] = false
    s = require('say')
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

  it("tests the substitution of variable types; nil", function()
    s:set('substitute_test', 'boolean = %s, nil = %s, number = %s, string = "%s", table = %s')
    local atable = {}
    assert(s('substitute_test', {true, nil, 100, 'some text', atable, n = 5}) == 'boolean = true, nil = nil, number = 100, string = "some text", table = ' .. tostring(atable))
  end)

  it("tests the set_fallback method", function()
    s:set_namespace('en')
    s:set('herp', 'derp')
    s:set_namespace('not-en')
    s:set('not-herp', 'not-derp')

    assert(s('not-herp') == 'not-derp')
    assert(s('herp') == 'derp')
  end)

  it("errors on bad type of param table", function()
    s:set_namespace('en')
    s:set('herp', 'derp %s')
    assert.has.error(function() s('herp', 1000) end, "expected parameter table to be a table, got 'number'")
  end)

  it("tests missing elements returns nil", function()
    assert(s('this does not exist') == nil)
  end)

  it("tests the wrong arg count", function()
    -- backward compatibility after the nil-safe fix, in which the 'n' field got precendence over #
    s:set('substitute_test', '1 = %s, 2 = %s')
    -- two arguments, but "n = 1"
    assert(s('substitute_test', {"one", "two", n = 1}) == '1 = one, 2 = two')
  end)

end)
