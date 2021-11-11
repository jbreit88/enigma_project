class Key

  attr_reader :key,
              :key_digits,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift

  def initialize(key = generate_key_digits)
    @key = key
    @key_digits = key.chars
    @a_shift = a_shift
    @b_shift = b_shift
    @c_shift = c_shift
    @d_shift = d_shift
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

  def all_shifts
    all_shifts = [a_shift, b_shift, c_shift, d_shift]
  end

  def generate_key_digits #in here to pass tests, but probably unneccesasarey
    key = ("0".."99999").to_a.sample
    key.rjust(5, '0')
  end

end
