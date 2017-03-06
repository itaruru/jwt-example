require 'jwt'
require 'pry'

puts 'RSA 有効期限付き'

payload = {
  data: 'RSA のデータ From id_rsa',
  # exp: Time.now.to_i + 10,
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

binding.pry

begin
  decoded_token = JWT.decode(token, rsa_public, true, {aud: 'Mealthy, User Uniq Token Here', verify_aud: true, :algorithm => 'RS256' })
rescue => e
  puts 'デコード前に有効期限を迎えてたので例外が送出される'
  puts e.message
end

p decoded_token
