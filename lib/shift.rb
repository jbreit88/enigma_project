module Shiftable

  def total_shift(key_shifts_hash, offset_shifts_hash)
    total_shift = key_shifts_hash.merge(offset_shifts_hash) {|key_shift, key_shift_value, offset_value| key_shift_value + offset_value}

    total_shift.values
  end
end
