SCREEN = [[false] * 50, [false] * 50, [false] * 50, [false] * 50, [false] * 50, [false] * 50]

INSTRUCTIONS = ['rect 1x1', 'rotate row y=0 by 7', 'rect 1x1', 'rotate row y=0 by 5', 'rect 1x1', 'rotate row y=0 by 5', 'rect 1x1', 'rotate row y=0 by 2', 'rect 1x1', 'rotate row y=0 by 3', 'rect 1x1', 'rotate row y=0 by 5', 'rect 1x1', 'rotate row y=0 by 3', 'rect 1x1', 'rotate row y=0 by 2', 'rect 1x1', 'rotate row y=0 by 3', 'rect 2x1', 'rotate row y=0 by 7', 'rect 6x1', 'rotate row y=0 by 3', 'rect 2x1', 'rotate row y=0 by 2', 'rect 1x2', 'rotate row y=1 by 10', 'rotate row y=0 by 3', 'rotate column x=0 by 1', 'rect 2x1', 'rotate column x=20 by 1', 'rotate column x=15 by 1', 'rotate column x=5 by 1', 'rotate row y=1 by 5', 'rotate row y=0 by 2', 'rect 1x2', 'rotate row y=0 by 5', 'rotate column x=0 by 1', 'rect 4x1', 'rotate row y=2 by 15', 'rotate row y=0 by 5', 'rotate column x=0 by 1', 'rect 4x1', 'rotate row y=2 by 5', 'rotate row y=0 by 5', 'rotate column x=0 by 1', 'rect 4x1', 'rotate row y=2 by 10', 'rotate row y=0 by 10', 'rotate column x=8 by 1', 'rotate column x=5 by 1', 'rotate column x=0 by 1', 'rect 9x1', 'rotate column x=27 by 1', 'rotate row y=0 by 5', 'rotate column x=0 by 1', 'rect 4x1', 'rotate column x=42 by 1', 'rotate column x=40 by 1', 'rotate column x=22 by 1', 'rotate column x=17 by 1', 'rotate column x=12 by 1', 'rotate column x=7 by 1', 'rotate column x=2 by 1', 'rotate row y=3 by 10', 'rotate row y=2 by 5', 'rotate row y=1 by 3', 'rotate row y=0 by 10', 'rect 1x4', 'rotate column x=37 by 2', 'rotate row y=3 by 18', 'rotate row y=2 by 30', 'rotate row y=1 by 7', 'rotate row y=0 by 2', 'rotate column x=13 by 3', 'rotate column x=12 by 1', 'rotate column x=10 by 1', 'rotate column x=7 by 1', 'rotate column x=6 by 3', 'rotate column x=5 by 1', 'rotate column x=3 by 3', 'rotate column x=2 by 1', 'rotate column x=0 by 1', 'rect 14x1', 'rotate column x=38 by 3', 'rotate row y=3 by 12', 'rotate row y=2 by 10', 'rotate row y=0 by 10', 'rotate column x=7 by 1', 'rotate column x=5 by 1', 'rotate column x=2 by 1', 'rotate column x=0 by 1', 'rect 9x1', 'rotate row y=4 by 20', 'rotate row y=3 by 25', 'rotate row y=2 by 10', 'rotate row y=0 by 15', 'rotate column x=12 by 1', 'rotate column x=10 by 1', 'rotate column x=8 by 3', 'rotate column x=7 by 1', 'rotate column x=5 by 1', 'rotate column x=3 by 3', 'rotate column x=2 by 1', 'rotate column x=0 by 1', 'rect 14x1', 'rotate column x=34 by 1', 'rotate row y=1 by 45', 'rotate column x=47 by 1', 'rotate column x=42 by 1', 'rotate column x=19 by 1', 'rotate column x=9 by 2', 'rotate row y=4 by 7', 'rotate row y=3 by 20', 'rotate row y=0 by 7', 'rotate column x=5 by 1', 'rotate column x=3 by 1', 'rotate column x=2 by 1', 'rotate column x=0 by 1', 'rect 6x1', 'rotate row y=4 by 8', 'rotate row y=3 by 5', 'rotate row y=1 by 5', 'rotate column x=5 by 1', 'rotate column x=4 by 1', 'rotate column x=3 by 2', 'rotate column x=2 by 1', 'rotate column x=1 by 3', 'rotate column x=0 by 1', 'rect 6x1', 'rotate column x=36 by 3', 'rotate column x=25 by 3', 'rotate column x=18 by 3', 'rotate column x=11 by 3', 'rotate column x=3 by 4', 'rotate row y=4 by 5', 'rotate row y=3 by 5', 'rotate row y=2 by 8', 'rotate row y=1 by 8', 'rotate row y=0 by 3', 'rotate column x=3 by 4', 'rotate column x=0 by 4', 'rect 4x4', 'rotate row y=4 by 10', 'rotate row y=3 by 20', 'rotate row y=1 by 10', 'rotate row y=0 by 10', 'rotate column x=8 by 1', 'rotate column x=7 by 1', 'rotate column x=6 by 1', 'rotate column x=5 by 1', 'rotate column x=3 by 1', 'rotate column x=2 by 1', 'rotate column x=1 by 1', 'rotate column x=0 by 1', 'rect 9x1', 'rotate row y=0 by 40', 'rotate column x=44 by 1', 'rotate column x=35 by 5', 'rotate column x=18 by 5', 'rotate column x=15 by 3', 'rotate column x=10 by 5', 'rotate row y=5 by 15', 'rotate row y=4 by 10', 'rotate row y=3 by 40', 'rotate row y=2 by 20', 'rotate row y=1 by 45', 'rotate row y=0 by 35', 'rotate column x=48 by 1', 'rotate column x=47 by 5', 'rotate column x=46 by 5', 'rotate column x=45 by 1', 'rotate column x=43 by 1', 'rotate column x=40 by 1', 'rotate column x=38 by 2', 'rotate column x=37 by 3', 'rotate column x=36 by 2', 'rotate column x=32 by 2', 'rotate column x=31 by 2', 'rotate column x=28 by 1', 'rotate column x=23 by 3', 'rotate column x=22 by 3', 'rotate column x=21 by 5', 'rotate column x=20 by 1', 'rotate column x=18 by 1', 'rotate column x=17 by 3', 'rotate column x=13 by 1', 'rotate column x=10 by 1', 'rotate column x=8 by 1', 'rotate column x=7 by 5', 'rotate column x=6 by 5', 'rotate column x=5 by 1', 'rotate column x=3 by 5', 'rotate column x=2 by 5', 'rotate column x=1 by 5'].freeze

def rect(x, y)
  y.times do |r|
    x.times do |c|
      SCREEN[r][c] = true
    end
  end
end

def rotate_row(r, n)
  SCREEN[r] = SCREEN[r].rotate(-n)
end

def rotate_col(c, n)
  col = []
  6.times { |i| col << SCREEN[i][c] }

  col = col.rotate(-n)
  6.times { |i| SCREEN[i][c] = col[i] }
end

def print_screen
  SCREEN.each do |row|
    row.each do |col|
      print col ? "\u2589" : ' '
    end
    puts
  end
  puts
end

######################################################################

print 'Part 1: '

INSTRUCTIONS.each do |i|
  if i =~ /rect/
    m = i.match(/(\d{1,2})x(\d{1,2})/)
    rect(m[1].to_i, m[2].to_i)
  elsif i =~ /rotate row/
    m = i.match(/y=(\d+) by (\d+)/)
    rotate_row(m[1].to_i, m[2].to_i)
  elsif i =~ /rotate column/
    m = i.match(/x=(\d+) by (\d+)/)
    rotate_col(m[1].to_i, m[2].to_i)
  end
end

count = 0
SCREEN.each do |r|
  count += r.count(true)
end


puts "The number of lit pixels is #{count}"

######################################################################

puts 'Part 2: '

print_screen
