require 'jwt'

puts 'RSA を使ったぱたーん'

payload = {
  data: 'RSA のデータ'
}

rsa_private = OpenSSL::PKey::RSA.generate(2048)
rsa_public = rsa_private.public_key

puts rsa_private
puts rsa_public

token = JWT.encode(payload, rsa_private, 'RS256')

puts ''
puts token
puts ''

decoded_token = JWT.decode(token, rsa_public, true, { :algorithm => 'RS256' })

p decoded_token
