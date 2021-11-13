module Helpable

  # Enigma class helper methods

  def generate_key # Generates a random 5 digit key.
    key = ("0".."99999").to_a.sample
    key.rjust(5, '0')
  end

  def default_date # Creates a 6 digit string representing today's date.
    date = Date.today
    date.strftime('%d%m%y')
  end

  def date_valid?(date) # Checks if date input is a valid date.
    day = date[0] + date[1]
    month = date[2] + date[3]
    year = date[4] + date[5]

    Date.valid_date? year.to_i, month.to_i, day.to_i
  end

  def error_message # Error for incorrectly input information.
    puts "That input is incorrect!"
    puts "Please input again."
  end



  # Calculate total shift values from keys and offsets

  def total_shift(key_shifts_hash, offset_shifts_hash)
    total_shift = key_shifts_hash.merge(offset_shifts_hash) {|key_shift, key_shift_value, offset_value| key_shift_value + offset_value}

    total_shift.values
  end

  # Create hashes containing information for encrypted and decrypted messages.

  def return_encryption_hash(message, key, date)
    return_info_hash = {
      encryption: message,
      key: key,
      date: date
    }
  end

  def return_decryption_hash(message, key, date)
    return_info_hash = {
      decryption: message,
      key: key,
      date: date
    }
  end

  def return_cracked_hash(message, key, date)
    return_info_hash = {
      decryption: message,
      shift_values: key,
      date: date
    }
  end

  # Create range arrays for shifts

  def a_shift_range(index)
    (0..10000).step(4).to_a.include?(index)
  end

  def b_shift_range(index)
    (1..10000).step(4).to_a.include?(index)
  end

  def c_shift_range(index)
    (2..10000).step(4).to_a.include?(index)
  end

  def d_shift_range(index)
    (3..10000).step(4).to_a.include?(index)
  end
end
