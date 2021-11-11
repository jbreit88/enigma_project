class Enigma
  include Shift

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

  def encrypt(message, key = generate_key, date = format_date)
    @message = message
    @key = Key.new(key)
    @offset = Offset.new(date)





  end
end
