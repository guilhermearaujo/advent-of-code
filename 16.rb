INPUT = '11100010111110100'.freeze
DISK_1_LENGTH = 272
DISK_2_LENGTH = 35651584

def read_data(data)
  data.split(//).map { |c| c == ?1 }
end

def print_data(data)
  data.map { |i| i ? ?1 : ?0 }.join
end

def dragonize(c)
  c + [false] + c.reverse.map { |i| !i }
end

def checksum(string)
  sum = []

  string.each_slice(2) do |m, n|
    sum << !(m ^ n)
  end

  return checksum(sum) if sum.count.even?

  print_data(sum)
end

######################################################################

print 'Part 1: '

string = read_data(INPUT)

string = dragonize(string) while string.length < DISK_1_LENGTH

puts "The checksum is #{checksum(string[0...DISK_1_LENGTH])}"

######################################################################

print 'Part 2: '

string = read_data(INPUT)

string = dragonize(string) while string.length < DISK_2_LENGTH

puts "The checksum is #{checksum(string[0...DISK_2_LENGTH])}"
