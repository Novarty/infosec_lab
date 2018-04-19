require 'test/unit'
require_relative 'Twofish'

# Define some useful constants and test some basic properties.
class TestBasics < Test::Unit::TestCase

  NULL_KEY_16_BYTES = ("\0" * 16).freeze
  NULL_BLOCK = ("\0" * 16).freeze
  BLOCK_SIZE = 16

  def test_invalid_key_size
    assert_raise ArgumentError do
      Twofish.new('short key')
    end
  end
end

class TestEcbEncryption < TestBasics

  def test_null_in_plaintext
    plaintext = "xxxxxxx\0\0yyyyyyy"
    key = pack_bytes('37fe26ff1cf66175f5ddf4c33b97a205')
    tf = Twofish.new(key)
    ciphertext = tf.encrypt(plaintext)
    assert_equal(plaintext, tf.decrypt(ciphertext))
  end

  def test_utf8_plaintext
    # this string is 16 bytes in length (but 14 chars)
    plaintext = pack_bytes('72c3a973657276c3a96573') + # 11 bytes, 9 chars
      '12345' # 5 bytes, 5 chars
    plaintext.force_encoding('UTF-8')
    key = pack_bytes('37fe26ff1cf66175f5ddf4c33b97a205')
    tf = Twofish.new(key)
    ciphertext = tf.encrypt(plaintext)
    assert_equal(plaintext.force_encoding('ASCII-8BIT'), tf.decrypt(ciphertext))
  end

  private

  # Convert ASCII hex representation into binary.
  def pack_bytes(byte_string)
    [byte_string].pack('H*')
  end

  # Repeatedly encrypt the given plain text n times
  # with the same key.
  def repeated_block_encrypt(key, plain, iterations)
    key_length = key.length
    iterations.times do
      tf = Twofish.new(key)
      cipher = tf.encrypt(plain)
      assert_equal(plain, tf.decrypt(cipher))
      key = (plain + key)[0, key_length]
      plain = cipher
    end
    plain
  end
end
