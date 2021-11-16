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
    # return_cracked_hash(decrypted_message.reverse.join, shifts_array, date)

    # Need another piece/helper method to take the date and shifts and generate the key used.
    #get positive shift integers
    test_shifts_array = shifts_array.reverse
    # positive_adjusted_shifts = []
    # shifts_array.each do |shift|
    #   if shift < 0
    #     change = shift + 27
    #     positive_adjusted_shifts << change
    #   else
    #     positive_adjusted_shifts << shift
    #   end
    # end

    #set shifts in array to ABCD sequence
    if message.length % 4 == 0
      test_shifts_array
    elsif message.length % 4 == 1
      test_shifts_array.rotate
    elsif message.length % 4 == 2
      test_shifts_array.rotate(2)
    elsif message.length % 4 == 3
      test_shifts_array.rotate(3)
    end

    #get date offset array
    date_squared = date.to_i ** 2
    date_offset_array = date_squared.to_s.chars.slice(-4..-1).map {|x| x.to_i}


    #Subtract offsets from shifts and put in array
    a_base_key = test_shifts_array[0] - date_offset_array[0]
    b_base_key = test_shifts_array[1] - date_offset_array[1]
    c_base_key = test_shifts_array[2] - date_offset_array[2]
    d_base_key = test_shifts_array[3] - date_offset_array[3]

    # if a_base_key < 0
    #   a_base_key += 27
    # end
    #
    # if b_base_key < 0
    #   b_base_key += 27
    # end
    #
    # if c_base_key < 0
    #   c_base_key += 27
    # end
    #
    # if d_base_key < 0
    #   d_base_key += 27
    # end

    key_base_values = [a_base_key, b_base_key, c_base_key, d_base_key].map {|key| key.to_s.rjust(2, '0')}

    #get all possibilities for each base key
    a_key_possibilities = (a_base_key..99).step(27).to_a.map {|step| step.to_s.rjust(2, '0')}
    b_key_possibilities = (b_base_key..99).step(27).to_a.map {|step| step.to_s.rjust(2, '0')}
    c_key_possibilities = (c_base_key..99).step(27).to_a.map {|step| step.to_s.rjust(2, '0')}
    d_key_possibilities = (d_base_key..99).step(27).to_a.map {|step| step.to_s.rjust(2, '0')}

    final_key = []
    a_key_possibilities.each do |a_poss|
      final_key << a_poss[0]
      final_key << a_poss[1]
      b_key_possibilities.each do |b_poss|
        if b_poss[0] == a_poss[1]
          final_key << b_poss[1]
          c_key_possibilities.each do |c_poss|
            if c_poss[0] == b_poss[1]
              final_key << c_poss[1]
              d_key_possibilities.each do |d_poss|
                if d_poss[0] == c_poss[1]
                  final_key << d_poss[1]
                  break
                else
                  final_key.clear
                  require "pry"; binding.pry
                end
              end
            else
              final_key.clear
            end
          end
        else
          final_key.clear
        end
      end
    end

    final_key_string = final_key.join

    return_cracked_hash(decrypted_message.reverse.join, final_key_string, date)


    # require "pry"; binding.pry

  end
end
