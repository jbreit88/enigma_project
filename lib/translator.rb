class Translator

  attr_reader :character_set,
              :message,
              :shift_values,
              :direction

  def initialize(character_set, message, shift_values, direction)
    @character_set = character_set
    @message = message
    @shift_values = shift_values
    @direction = direction
  end
end
