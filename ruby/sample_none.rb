require 'jwt'

payload = {
  data: 'sample'
}

# IMPORTANT: set nil as password parameter
token = JWT.encode(payload, nil, 'none')

puts ''
puts token
puts ''

decoded_token = JWT.decode(token, nil, false)

p decoded_token
