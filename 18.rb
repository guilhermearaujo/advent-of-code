SAFE = ?.
TRAP = ?^
FIRST_ROW = '^^^^......^...^..^....^^^.^^^.^.^^^^^^..^...^^...^^^.^^....^..^^^.^.^^...^.^...^^.^^^.^^^^.^^.^..^.^'.split(//)

def count_safe_tiles(seed, rows)
  path = seed
  count = path.count(SAFE)

  (rows - 1).times do
    next_path = []

    seed.length.times do |c|
      next_path << calculate_tile(path, c)
    end

    path = next_path
    count += path.count(SAFE)
  end

  count
end

def calculate_tile(path, c)
  left  = c > 0 ? path[c - 1] : SAFE
  right = path[c + 1] || SAFE

  left != right ? TRAP : SAFE
end

######################################################################

print 'Part 1: '

puts "There are #{count_safe_tiles(FIRST_ROW, 40)} safe tiles"

######################################################################

print 'Part 2: '

puts "There are #{count_safe_tiles(FIRST_ROW, 400000)} safe tiles"
