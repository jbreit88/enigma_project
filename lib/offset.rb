class Offset

  attr_reader :date,
              :offset_digits,
              :a_offset,
              :b_offset,
              :c_offset,
              :d_offset,
              :offset_shifts

  def initialize(date)
    @date = date
    @offset_digits = get_digits
    @a_offset = @offset_digits[0]
    @b_offset = @offset_digits[1]
    @c_offset = @offset_digits[2]
    @d_offset = @offset_digits[3]
    @offset_shifts = {a_shift: a_offset, b_shift: b_offset, c_shift: c_offset, d_shift: d_offset}
  end

  def square_date
    @date.to_i ** 2
  end

  def get_digits
    digits = square_date.to_s.chars.slice(-4..-1)
    digits.map {|digit| digit.to_i}
  end
end
