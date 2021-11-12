require_relative 'shift'

class Enigma
  include Shiftable

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

  def generate_key
    key = ("0".."99999").to_a.sample
    key.rjust(5, '0')
  end

  # def check_date(date)
  #   date_check = Date.strptime(date, '%d%m%y')
  #   require "pry"; binding.pry
  #   if Date.valid_date?(date)
  #     true
  #   elsif
  #     false
  #   end
  # end
  #
  # def date_valid?(date)
  #   require "pry"; binding.pry
  #  Date.parse(date).strftime('%d%m%y') == date
  # end



  def format_date
    date = Date.today
    date.strftime('%d%m%y')
  end

  def error_message
    puts "That input is incorrect!"
    puts "Please input again."
  end

  # def message_format(message)
  #   message.downcase.chars
  # end

  def encrypt(message, key = generate_key, date = format_date)
    return error_message unless key.length == 5
    return error_message unless date.length == 6

    @message = message.downcase.chars
    @key = Key.new(key)
    @offset = Offset.new(date)

    final_shifted_values = total_shift(@key.key_shifts, @offset.offset_shifts)

    encrypted_message = []

    @message.each_with_index do |character, index|
      slice_index = @character_set.find_index(character)
      if !@character_set.include?(character)
        encrypted_message << character
      elsif (0..1000).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(final_shifted_values[0]).slice(slice_index)
        encrypted_message << encrypted_character
      elsif (1..1001).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(final_shifted_values[1]).slice(slice_index)
        encrypted_message << encrypted_character
      elsif (2..1002).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(final_shifted_values[2]).slice(slice_index)
        encrypted_message << encrypted_character
      elsif (3..1003).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(final_shifted_values[3]).slice(slice_index)
        encrypted_message << encrypted_character
      end
    end
    encrypted_message.join
    require "pry"; binding.pry
  end


  def decrypt(message, key, date)
    return error_message unless key.length == 5
    return error_message unless date.length == 6

    @message = message.downcase.chars
    @key = Key.new(key)
    @offset = Offset.new(date)

    final_shifted_values = total_shift(@key.key_shifts, @offset.offset_shifts)

    encrypted_message = []

    @message.each_with_index do |character, index|
      slice_index = @character_set.find_index(character)
      if !@character_set.include?(character)
        encrypted_message << character
      elsif (0..1000).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(final_shifted_values[0]).slice(slice_index)
        encrypted_message << encrypted_character
      elsif (1..1001).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(final_shifted_values[1]).slice(slice_index)
        encrypted_message << encrypted_character
      elsif (2..1002).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(final_shifted_values[2]).slice(slice_index)
        encrypted_message << encrypted_character
      elsif (3..1003).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(final_shifted_values[3]).slice(slice_index)
        encrypted_message << encrypted_character
      end
    end
    encrypted_message.join
  end


end
