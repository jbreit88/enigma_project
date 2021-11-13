class Offset

  attr_reader :date,
              :offset_digits,
              :offset_shifts

  def initialize(date)
    @date = date
    @offset_digits = get_digits
    @offset_shifts = {a_shift: @offset_digits[0], b_shift: @offset_digits[1], c_shift: @offset_digits[2], d_shift: @offset_digits[3]}
  end

  def square_date
    @date.to_i ** 2
  end

  def get_digits
    digits = square_date.to_s.chars.slice(-4..-1)
    digits.map {|digit| digit.to_i}
  end
end
