require 'set'

class Djikstra
  attr_accessor :start, :d, :pred, :q

  FAVORITE_NUMBER = 1358
  WALL = "\u2589"
  SPACE = ' '

  def initialize(start)
    self.start = start
    reset
  end

  def reset
    self.d = { start => 0 }
    self.pred = { start => nil }
    self.q = Set.new
  end

  def find(target)
    until d[target]
      node = d.reject { |k, v| q.include?(k) }
              .min_by { |k, v| v }

      return -Float::INFINITY unless node

      relax(node[0])
    end

    d[target]
  end

  def count_distant_up_to(distance)
    until d.max_by { |k, v| v }[1] > distance
      node = d.reject { |k, v| q.include?(k) }
              .min_by { |k, v| v }

      return -Float::INFINITY unless node

      relax(node[0])
    end

    d.count { |k, v| v <= 50 }
  end

  def print_floor(key, spacer = ' ')
    a, b = key_to_xy(key)
    print '   '
    a.times { |i| print "#{i % 10}#{spacer}" }
    puts ''

    b.times do |y|
      print "#{y % 10}#{spacer}"
      a.times do |x|
        print "#{wall?(x, y) ? WALL : SPACE}#{spacer}"
      end
      puts ''
    end
  end

  private

  def wall?(x, y)
    n = (x*x + 3*x + 2*x*y + y + y*y) + FAVORITE_NUMBER
    ("%b" % n).split(//).count('1') % 2 != 0
  end

  def adjacents(node)
    x, y = key_to_xy(node)
    adj = []
    adj << "#{x - 1},#{y}" if x - 1 >= 0 && !wall?(x - 1, y)
    adj << "#{x + 1},#{y}" if !wall?(x + 1, y)
    adj << "#{x},#{y - 1}" if y - 1 >= 0 && !wall?(x, y - 1)
    adj << "#{x},#{y + 1}" if !wall?(x, y + 1)
    adj
  end

  def key_to_xy(key)
    key.match(/(\d+),(\d+)/)[1..2].map(&:to_i)
  end

  def relax(u)
    adjacents(u).each do |v|
      if (d[u] || Float::INFINITY) + 1 < (d[v] || Float::INFINITY)
        d[v] = d[u] + 1
        pred[v] = u
      end

      self.q << u
    end
  end
end

######################################################################

print 'Part 1: '

d = Djikstra.new('1,1')

puts "The number of steps to get from (1, 1) to (31, 39) is #{d.find('31,39')}"

######################################################################

print 'Part 2: '

d.reset

puts "The number of coordinates that are 50 steps or less to (1, 1) is #{d.count_distant_up_to(50)}"
