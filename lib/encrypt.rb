require 'date'
require './lib/enigma'

if ARGV.count != 2
  puts "Invalid input."
  exit
end

message_file = ARGV[0]
encrypted_file = ARGV[1]

def encrypt_message(message_file, encrypted_file)
  enigma = Enigma.new

  message_text = File.read(message_file)

  encrypted_text = File.new(encrypted_file, "w")

  encrypt_info = enigma.encrypt(message_text)

  encrypted_text.puts(encrypt_info[:encryption])
  encrypted_text.close

  puts "Created '#{encrypted_file}' with the key #{encrypt_info[:key]} and the date #{encrypt_info[:date]}."
end

encrypt_message(message_file, encrypted_file)
