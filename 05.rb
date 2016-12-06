require 'digest'

DOOR_ID = 'uqwqemis'.freeze

MD5 = Digest::MD5.new

######################################################################

print 'Part 1: '

password = ''

i = 0
loop do
  hash = Digest::MD5.hexdigest "#{DOOR_ID}#{i}"
  password << hash[5] if hash =~ /^00000/
  password.length == 8 ? break : i += 1
end

puts "The password is #{password}"

######################################################################

print 'Part 2: '

password = [nil] * 8

i = 0
loop do
  hash = Digest::MD5.hexdigest "#{DOOR_ID}#{i}"

  if hash =~ /^00000[0-7]/
    p = hash[5].to_i
    password[p] = hash[6] unless password[p]
  end

  password.all? ? break : i += 1
end

puts "The password is #{password.join}"
