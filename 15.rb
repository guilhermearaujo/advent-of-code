CONFIGURATION = [
  'Disc #1 has 13 positions; at time=0, it is at position 11.',
  'Disc #2 has 5 positions; at time=0, it is at position 0.',
  'Disc #3 has 17 positions; at time=0, it is at position 11.',
  'Disc #4 has 3 positions; at time=0, it is at position 0.',
  'Disc #5 has 7 positions; at time=0, it is at position 2.',
  'Disc #6 has 19 positions; at time=0, it is at position 17.'
].freeze

@discs = []

CONFIGURATION.each do |c|
  id, total, pos = c.match(/Disc #(\d) has (\d+) positions; at time=0, it is at position (\d+)/)[1..3].map(&:to_i)
  @discs << { id: id, positions: total, current: pos }
end

def calculate_time
  wait = 0

  while true
    break if @discs.all? do |d|
      (d[:current] + d[:id] + wait) % d[:positions] == 0
    end
    wait += 1
  end

  wait
end

######################################################################

print 'Part 1: '

puts "The button should be pushed at time = #{calculate_time}"

######################################################################

print 'Part 2: '

@discs << { id: 7, positions: 11, current: 0 }

puts "The button should be pushed at time = #{calculate_time}"
