require 'date'
require './lib/enigma'

if ARGV.count != 3
  puts "Invalid input."
  exit
end

message_file = ARGV[0]
cracked_file = ARGV[1]
message_date = ARGV[2]

def crack_message(message_file, cracked_file, message_date)

  enigma = Enigma.new

  message_text = File.read(message_file)


  cracked_text = File.new(cracked_file, "w")


  crack_info = enigma.crack(message_text, message_date)

  cracked_text.puts(crack_info[:decryption])
  cracked_text.close

  puts "Created '#{cracked_file}' with the shifts #{crack_info[:shift_values]}."
end


crack_message(message_file, cracked_file, message_date)
