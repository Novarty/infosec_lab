require_relative "Twofish"

key = ['5d9d4eeffa9151575524f115815a12e0']
twofish = Twofish.new(key.pack("H*"))

puts ciphertext = twofish.encrypt('Hello World!1!!; Lorem ipsum dolor sit amet')
puts twofish.decrypt(ciphertext)
