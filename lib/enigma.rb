require_relative 'helpable'
require './lib/key'
require './lib/offset'
require './lib/translator'

class Enigma
  include Helpable

  attr_reader :character_set

  def initialize
    @character_set = ('a'..'z').to_a << " "
  end

  def encrypt(message, key = generate_key, date = default_date)
    return error_message unless key.length == 5
    return error_message unless date.length == 6
    return error_message unless date_valid?(date) == true

    translator = Translator.new(@character_set, message, key, date, 1)
    translator.translate
  end

  def decrypt(message, key, date)
    return error_message unless key.length == 5
    return error_message unless date.length == 6
    return error_message unless date_valid?(date) == true

    translator = Translator.new(@character_set, message, key, date, -1)
    translator.translate
  end

  def crack(message, date = default_date)
    message = message.chomp.downcase.chars
    message_last_four = message.slice(-4..-1)
    shifts_array = []

    message_last_four.each_with_index do |character, index|
      if index == 0
        char_set_index = @character_set.find_index(character)
        shift = 26 - char_set_index
        shifts_array.unshift(shift)
      elsif index == 1
        char_set_index = @character_set.find_index(character)
        shift = 4 - char_set_index
        shifts_array.unshift(shift)
      elsif index == 2
        char_set_index = @character_set.find_index(character)
        shift = 13 - char_set_index
        shifts_array.unshift(shift)
      elsif index == 3
        char_set_index = @character_set.find_index(character)
        shift = 3 - char_set_index
        shifts_array.unshift(shift)
      end
    end

    decrypted_message = []

    message.reverse.each_with_index do |character, index|
      shift = index % shifts_array.length
      slice_index = @character_set.find_index(character)
      if !@character_set.include?(character)
        decrypted_message << character
      else
        encrypted_character = @character_set.rotate(shifts_array[shift]).slice(slice_index)
        decrypted_message << encrypted_character
      end
    end
    return_cracked_hash(decrypted_message.reverse.join, shifts_array, date)

    # Need another piece/helper method to take the date and shifts and generate the key used.
  end
end
