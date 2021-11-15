class Key

  attr_reader :key,
              :key_digits,
              :key_shifts

  def initialize(key)
    @key = key
    @key_digits = key.chars
    @key_shifts = {
      a_shift: a_shift,
      b_shift: b_shift,
      c_shift: c_shift,
      d_shift: d_shift
    }
  end

  def a_shift
    shift = @key_digits[0] + @key_digits[1]
    shift.to_i
  end

  def b_shift
    shift = @key_digits[1] + @key_digits[2]
    shift.to_i
  end

  def c_shift
    shift = @key_digits[2] + @key_digits[3]
    shift.to_i
  end

  def d_shift
    shift = @key_digits[3] + @key_digits[4]
    shift.to_i
  end
end
