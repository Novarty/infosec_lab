require_relative "Twofish"
# key1 = '1234567890123456' # через текстовое представление
key1 = ['5d9d4eeffa9151575524f115815a12e0'].pack("H*")
twofish1 = Twofish.new(key1)
puts ciphertext1 = twofish1.encrypt('Hello World!1!!; Lorem ipsum dolor sit amet')
puts twofish1.decrypt(ciphertext1)

puts

# key2 = '1234567890123456' # через текстовое представление
key2 = ['5d9d4eeffa9151575524f115815a12e0'].pack("H*") # через массив байтов
twofish2 = Twofish.new(key2, :mode => :rcbc)
twofish2.vector = 'abcdefghijklmnop'
puts ciphertext2 = twofish2.encrypt('Lorem ipsum dolor sit amet')
puts twofish2.decrypt(ciphertext2)
