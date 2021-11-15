require_relative 'helpable'
require './lib/key'
require './lib/offset'

class Enigma
  include Helpable

  attr_reader :message,
              :key,
              :offset,
              :character_set

  def initialize
    @message = nil
    @key = nil
    # @date = check_date(date)
    @offset = nil
    @character_set = ('a'..'z').to_a << " "
  end

  def encrypt(message, key = generate_key, date = default_date)
    return error_message unless key.length == 5
    return error_message unless date.length == 6
    return error_message unless date_valid?(date) == true

    @message = message.downcase.chars
    @key = Key.new(key)
    @offset = Offset.new(date)


    encrypted_message = []

    final_shifted_values = total_shift(@key.key_shifts, @offset.offset_shifts)

    @message.each_with_index do |character, index|
      shift = index % final_shifted_values.length
      slice_index = @character_set.find_index(character)
      if !@character_set.include?(character)
        encrypted_message << character
      else
        encrypted_character = @character_set.rotate(final_shifted_values[shift]).slice(slice_index)
        encrypted_message << encrypted_character
        # elsif (0..1000).step(4).to_a.include?(index)
        #   encrypted_character = @character_set.rotate(final_shifted_values[shift]).slice(slice_index)
        #   encrypted_message << encrypted_character
        # elsif (1..1001).step(4).to_a.include?(index)
        #   encrypted_character = @character_set.rotate(final_shifted_values[1]).slice(slice_index)
        #   encrypted_message << encrypted_character
        # elsif (2..1002).step(4).to_a.include?(index)
        #   encrypted_character = @character_set.rotate(final_shifted_values[2]).slice(slice_index)
        #   encrypted_message << encrypted_character
        # elsif (3..1003).step(4).to_a.include?(index)
        #   encrypted_character = @character_set.rotate(final_shifted_values[3]).slice(slice_index)
        #   encrypted_message << encrypted_character
      end
    end
    return_encryption_hash(encrypted_message.join, key, date)
  end


  def decrypt(message, key, date)
    return error_message unless key.length == 5
    return error_message unless date.length == 6
    return error_message unless date_valid?(date) == true

    @message = message.downcase.chars
    @key = Key.new(key)
    @offset = Offset.new(date)

    final_shifted_values = total_shift(@key.key_shifts, @offset.offset_shifts)

    decrypted_message = []

    @message.each_with_index do |character, index|
      shift = index % final_shifted_values.length
      slice_index = @character_set.find_index(character)
      if !@character_set.include?(character)
        decrypted_message << character
      else
        encrypted_character = @character_set.rotate(-final_shifted_values[shift]).slice(slice_index)
        decrypted_message << encrypted_character
      # elsif a_shift_range(index)
      #   encrypted_character = @character_set.rotate(-final_shifted_values[0]).slice(slice_index)
      #   decrypted_message << encrypted_character
      # elsif b_shift_range(index)
      #   encrypted_character = @character_set.rotate(-final_shifted_values[1]).slice(slice_index)
      #   decrypted_message << encrypted_character
      # elsif c_shift_range(index)
      #   encrypted_character = @character_set.rotate(-final_shifted_values[2]).slice(slice_index)
      #   decrypted_message << encrypted_character
      # elsif d_shift_range(index)
      #   encrypted_character = @character_set.rotate(-final_shifted_values[3]).slice(slice_index)
      #   decrypted_message << encrypted_character
      end
    end
    return_decryption_hash(decrypted_message.join, key, date)
  end

  def crack(message, date = default_date)
    message = message.chomp.downcase.chars
    # require "pry"; binding.pry
    message_last_four = message.slice(-4..-1)
    shifts_array = [] # array of integers indicating the four shifts for letters

    message_last_four.each_with_index do |character, index|
      if index == 0
        char_set_index = @character_set.find_index(character)
        shift = 26 - char_set_index
        shifts_array << shift
      elsif index == 1
        char_set_index = @character_set.find_index(character)
        shift = 4 - char_set_index
        shifts_array << shift
      elsif index == 2
        char_set_index = @character_set.find_index(character)
        shift = 13 - char_set_index
        shifts_array << shift
      elsif index == 3
        char_set_index = @character_set.find_index(character)
        shift = 3 - char_set_index
        shifts_array << shift
      end
    end

    decrypted_message = []

    message.reverse.each_with_index do |character, index|
      slice_index = @character_set.find_index(character)
      if !@character_set.include?(character)
        decrypted_message << character
      elsif a_shift_range(index)
        encrypted_character = @character_set.rotate(shifts_array[3]).slice(slice_index)
        decrypted_message << encrypted_character
      elsif b_shift_range(index)
        encrypted_character = @character_set.rotate(shifts_array[2]).slice(slice_index)
        decrypted_message << encrypted_character
      elsif c_shift_range(index)
        encrypted_character = @character_set.rotate(shifts_array[1]).slice(slice_index)
        decrypted_message << encrypted_character
      elsif d_shift_range(index)
        encrypted_character = @character_set.rotate(shifts_array[0]).slice(slice_index)
        decrypted_message << encrypted_character
      end
    end
    return_cracked_hash(decrypted_message.reverse.join, shifts_array, date)
  end
end
