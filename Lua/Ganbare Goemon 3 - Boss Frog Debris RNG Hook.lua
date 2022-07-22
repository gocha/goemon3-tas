-- Ganbare Goemon 3: Boss Frog RNG display specific to the debris upon appearance

function math.average(t)
  local sum = 0
  for _,v in pairs(t) do -- Get the sum of all numbers in t
    sum = sum + v
  end
  return sum / #t
end

local offsets = {}

event.onmemoryexecute(function()
  offsets = {}
end, 0x8BBFE1, "Before New Pieces")

event.onmemoryexecute(function()
  local sprite_base = emu.getregister("X")
  local offset = mainmemory.read_s8(1)
  -- print(string.format("$%06X: %d", sprite_base, offset))
  table.insert(offsets, offset)
end, 0x8BC006, "New Piece")

event.onmemoryexecute(function()
  table.sort(offsets)
  print(table.concat(offsets, ", "))
  print("Average: " .. math.average(offsets))
  print("")
  offsets = {}
end, 0x8BC022, "After New Pieces")
