describe("utils", function()
  local utils = require("simulators.utils")

  it("converts 'Hello\nWorld\nHow\nAre\nYou' to {'Hello', 'World', 'How', 'Are', 'You'}", function()
    local input = "Hello\nWorld\nHow\nAre\nYou"
    local expected = { "Hello", "World", "How", "Are", "You" }
    local actual = utils.lines_str_to_table(input)
    assert.are.same(expected, actual)
  end)

  it("converts 'A\nB\nC' to {'A', 'B', 'C'}", function()
    local input = "A\nB\nC"
    local expected = { "A", "B", "C" }
    local actual = utils.lines_str_to_table(input)
    assert.are.same(expected, actual)
  end)

  it("converts 'One Line Only' to {'One Line Only'}", function()
    local input = "One Line Only"
    local expected = { "One Line Only" }
    local actual = utils.lines_str_to_table(input)
    assert.are.same(expected, actual)
  end)

  it("converts '' to {}", function()
    local input = ""
    local expected = {}
    local actual = utils.lines_str_to_table(input)
    assert.are.same(expected, actual)
  end)
end)
