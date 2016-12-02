ROUTE = %w(L2 L3 L3 L4 R1 R2 L3 R3 R3 L1 L3 R2 R3 L3 R4 R3 R3 L1 L4 R4 L2 R5 R1 L5 R1 R3 L5 R2 L2 R2 R1 L1 L3 L3 R4 R5 R4 L1 L189 L2 R2 L5 R5 R45 L3 R4 R77 L1 R1 R194 R2 L5 L3 L2 L1 R5 L3 L3 L5 L5 L5 R2 L1 L2 L3 R2 R5 R4 L2 R3 R5 L2 L2 R3 L3 L2 L1 L3 R5 R4 R3 R2 L1 R2 L5 R4 L5 L4 R4 L2 R5 L3 L2 R4 L1 L2 R2 R3 L2 L5 R1 R1 R3 R4 R1 R2 R4 R5 L3 L5 L3 L3 R5 R4 R1 L3 R1 L3 R3 R3 R3 L1 R3 R4 L5 L3 L1 L5 L4 R4 R1 L4 R3 R3 R5 R4 R3 R3 L1 L2 R1 L4 L4 L3 L4 L3 L5 R2 R4 L2).freeze

DIRECTIONS = %i(n e s w).freeze

def setup
  @direction = :n
  @x = 0
  @y = 0
  @path = [{ x: 0, y: 0}]
end

def turn(d)
  index =
    if d == 'L'
      (DIRECTIONS.index(@direction) - 1) % 4
    else
      (DIRECTIONS.index(@direction) + 1) % 4
    end

  @direction = DIRECTIONS[index]
end

def walk(n, &block)
  n.times do
    case @direction
    when :n then @y += 1
    when :e then @x += 1
    when :s then @y -= 1
    when :w then @x -= 1
    end

    yield block if block
  end
end

######################################################################

print 'Part 1: '

setup

ROUTE.each do |command|
  turn(command[0])
  walk(command[1..-1].to_i)
end

puts "Easter Bunny HQ is #{@x.abs + @y.abs} blocks away"

######################################################################

print 'Part 2: '

setup

ROUTE.each do |command|
  turn(command[0])

  break unless walk(command[1..-1].to_i) do
    break puts "Easter Bunny HQ is #{@x.abs + @y.abs} blocks away" if @path.include?(x: @x, y: @y)
    @path << { x: @x, y: @y }
  end
end
