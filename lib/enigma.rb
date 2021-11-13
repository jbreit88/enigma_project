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

  def date_valid?(date)
    day = date[0] + date[1]
    month = date[2] + date[3]
    year = date[4] + date[5]

    Date.valid_date? year.to_i, month.to_i, day.to_i
  end

  def format_date
    date = Date.today
    date.strftime('%d%m%y')
  end

  def error_message
    puts "That input is incorrect!"
    puts "Please input again."
  end

  def encrypt(message, key = generate_key, date = format_date)
    return error_message unless key.length == 5
    return error_message unless date.length == 6
    return error_message unless date_valid?(date) == true

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
      slice_index = @character_set.find_index(character)
      if !@character_set.include?(character)
        decrypted_message << character
      elsif (0..1000).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(-final_shifted_values[0]).slice(slice_index)
        decrypted_message << encrypted_character
      elsif (1..1001).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(-final_shifted_values[1]).slice(slice_index)
        decrypted_message << encrypted_character
      elsif (2..1002).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(-final_shifted_values[2]).slice(slice_index)
        decrypted_message << encrypted_character
      elsif (3..1003).step(4).to_a.include?(index)
        encrypted_character = @character_set.rotate(-final_shifted_values[3]).slice(slice_index)
        decrypted_message << encrypted_character
      end
    end
    return_decryption_hash(decrypted_message.join, key, date)
  end
end
