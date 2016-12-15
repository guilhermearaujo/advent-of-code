require 'digest'

SALT = 'cuanljph'.freeze

def generate_otp(i, stretch = false)
  i -= 1

  hash = nil

  while true
    i += 1
    hash = Digest::MD5.hexdigest "#{SALT}#{i}"

    d = (stretch ? stretch(hash) : hash).match(/(.)\1{2}/)

    next unless d

    1000.times do |t|
      sub_hash = Digest::MD5.hexdigest "#{SALT}#{i + t + 1}"

      sub_hash = stretch(sub_hash) if stretch

      return { hash: hash, index: i } if sub_hash =~ /#{d[1]}{5}/
    end
  end
end

@look_up = {}

def stretch(hash)
  return @look_up[hash] if @look_up.key?(hash)

  s_hash = hash
  2016.times { s_hash = Digest::MD5.hexdigest(s_hash) }

  @look_up[hash] = s_hash
  s_hash
end


######################################################################

print 'Part 1: '


otps = []

i = 0
64.times do
  otps << generate_otp(i)
  i = otps.last[:index] + 1
end

puts "The 64th OTP is generated with index #{otps.last[:index]}"

######################################################################

print 'Part 2: '

otps = []

i = 0

64.times do
  otps << generate_otp(i, true)
  i = otps.last[:index] + 1
end

puts "The 64th OTP is generated with index #{otps.last[:index]}"
