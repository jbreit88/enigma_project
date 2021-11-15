require_relative 'helpable'
require './lib/key'
require './lib/offset'

class Translator
  include Helpable

  attr_reader :character_set,
              :message,
              :key,
              :date,
              :offset,
              :direction,
              :shift_values,
              :changed_message

  # attr_writer :shift_values


  def initialize(character_set, message, key, date, direction)
    @character_set = character_set
    @message = message.downcase.chars
    @key = Key.new(key)
    @date = date
    @offset = Offset.new(date)
    @direction = direction
    @shift_values = nil
    @changed_message = []
  end

  def get_rotation_from_index(index)
    index % @shift_values.length
  end

  def translate
    @shift_values = total_shift(@key.key_shifts, @offset.offset_shifts)

    @message.each_with_index do |character, index|
      rotation = get_rotation_from_index(index)

      slice_index = @character_set.find_index(character)
      if !@character_set.include?(character)
        @changed_message << character
      else
        translated_character = @character_set.rotate((@shift_values[rotation]) * @direction).slice(slice_index)
        @changed_message << translated_character
      end
    end

    if @direction == 1
      return_encryption_hash(@changed_message.join, @key, @date)
    elsif @direction == -1
      return_decryption_hash(@changed_message.join, @key, @date)
    end
  end
end
