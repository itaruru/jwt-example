require 'jwt'

puts 'RSA を使ったぱたーん（openssl 4096 で作成済みキー利用）'

payload = {
  data: 'RSA のデータ From id_rsa'
}

rsa_private = OpenSSL::PKey.read(File.read('../private.pem'))
rsa_public = OpenSSL::PKey.read(File.read('../public.pem'))

puts rsa_private
puts rsa_public

token = JWT.encode(payload, rsa_private, 'RS256')

puts ''
puts token
puts ''

decoded_token = JWT.decode(token, rsa_public, true, { :algorithm => 'RS256' })

p decoded_token
