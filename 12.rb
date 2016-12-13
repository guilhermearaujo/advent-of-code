INSTRUCTIONS = ['cpy 1 a', 'cpy 1 b', 'cpy 26 d', 'jnz c 2', 'jnz 1 5', 'cpy 7 c', 'inc d', 'dec c', 'jnz c -2', 'cpy a c', 'inc a', 'dec b', 'jnz b -2', 'cpy c b', 'dec d', 'jnz d -6', 'cpy 13 c', 'cpy 14 d', 'inc a', 'dec d', 'jnz d -2', 'dec c', 'jnz c -5'].freeze

def execute(instruction)
  cmd, x, y = instruction.match(/([a-z]{3}) ([a-z]|\d+)\s*([a-z]|[-\d]+)*/)[1..3]
  case cmd
  when 'cpy'
    @registers[y] = @registers[x] || x.to_i
    @i += 1
  when 'inc'
    @registers[x] += 1
    @i += 1
  when 'dec'
    @registers[x] -= 1
    @i += 1
  when 'jnz'
    (@registers[x] || x.to_i) == 0 ? @i += 1 : @i += y.to_i
  end
end

######################################################################

print 'Part 1: '

@registers = { 'a' => 0, 'b' => 0, 'c' => 0, 'd' => 0 }

@i = 0
while @i < INSTRUCTIONS.length
  execute(INSTRUCTIONS[@i])
end

puts "The value in register 'a' is #{@registers['a']}"

######################################################################

print 'Part 2: '

@registers = { 'a' => 0, 'b' => 0, 'c' => 1, 'd' => 0 }

@i = 0
while @i < INSTRUCTIONS.length
  execute(INSTRUCTIONS[@i])
end

puts "The value in register 'a' is #{@registers['a']}"
