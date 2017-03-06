require 'jwt'
require 'pry'

puts 'HMAC を使ったぱたーん'

payload = {
  data: '日本語のぺいろーどもいける？'
}

hmac_secret = 'my$ecretK3y'
hmac_secret = 'Uc9LiEWKWT3$zqpua'

token = JWT.encode(payload, hmac_secret, 'HS256')

puts ''
puts token
puts ''

binding.pry

decoded_token = JWT.decode(token, hmac_secret, true, {algorithm: 'HS256'})

p decoded_token
