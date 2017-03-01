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

puts ''
puts '--------------------------------------------------------'
puts ''

puts 'HMAC を使ったぱたーん'

payload = {
  data: '日本語のぺいろーどもいける？'
}

hmac_secret = 'my$ecretK3y'

token = JWT.encode(payload, hmac_secret, 'HS256')

puts ''
puts token
puts ''

decoded_token = JWT.decode(token, hmac_secret, true, { :algorithm => 'HS256' })

p decoded_token

puts ''
puts '--------------------------------------------------------'
puts ''

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

puts ''
puts '--------------------------------------------------------'
puts ''

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


puts ''
puts '--------------------------------------------------------'
puts ''

puts '有効期限付き'


payload = {
  data: 'RSA のデータ From id_rsa',
  exp: Time.now.to_i + 10,
  aud: 'Mealthy, User Uniq Token Here'
}

rsa_private = OpenSSL::PKey.read(File.read('../private.pem'))
rsa_public = OpenSSL::PKey.read(File.read('../public.pem'))

puts rsa_private
puts rsa_public

token = JWT.encode(payload, rsa_private, 'RS256')

puts ''
puts token
puts ''

# sleep(1)

begin
  decoded_token = JWT.decode(token, rsa_public, true, {aud: 'Mealthy, User Uniq Token Here', verify_aud: true, :algorithm => 'RS256' })
rescue => e
  puts 'デコード前に有効期限を迎えてたので例外が送出される'
  puts e.message
end

p decoded_token
