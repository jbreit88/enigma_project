require 'date'
require './lib/enigma'

encrypted_file = ARGV[0]
decrypted_file = ARGV[1]
decrypt_key = ARGV[2]
decrypt_date = ARGV[3]

def decrypt_message(encrypted_file, decrypted_file, decrypt_key, decrypt_date)
  enigma = Enigma.new

  encrypted_text = File.read(encrypted_file)

  decrypted_text = File.new(decrypted_file, "w")

  decrypt_info = enigma.decrypt(encrypted_text, decrypt_key, decrypt_date)

  decrypted_text.puts(decrypt_info[:decryption])
  decrypted_text.close

  puts "Created '#{decrypted_file}' with the key #{decrypt_key} and the date #{decrypt_date}."
end

decrypt_message(encrypted_file,
decrypted_file,
decrypt_key,
decrypt_date)

#four command line arguments

#existing file with encrypted message
#file to write decrypted message
#decryption key
#date used for decryption

#output to screen filename, key, date.
