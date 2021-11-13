require './lib/enigma'
require './lib/key'
require './lib/offset'
require './lib/helpable'

RSpec.describe Enigma do
  let(:enigma) {Enigma.new}

  it 'exists' do
    expect(enigma).to be_a Enigma
  end

  it 'has attributes' do
    expect(enigma.message).to eq nil
    expect(enigma.key).to eq nil
    expect(enigma.offset).to eq nil
    expect(enigma.character_set).to be_a Array
    expect(enigma.character_set.length).to eq 27
  end

  it 'can generate random 5 digit keys' do
    expect(enigma.generate_key).to be_a String

    expect(enigma.generate_key.length).to eq 5

    expect("00000".."99999").to include(enigma.generate_key)
  end

  it 'returns date in string with 6 digits' do
    expect(enigma.default_date).to be_a String
    expect(enigma.default_date.length).to eq 6
  end

  describe '#encrypt' do
    before(:each) do
      @enigma_1 = Enigma.new
      @enigma_1.encrypt("Hello World!", "01234", "091299")
    end

    it 'takes three arguments' do
      expect(@enigma_1.message).to eq(["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "!"])
      expect(@enigma_1.key).to be_a Key
      expect(@enigma_1.key.key_digits).to be_a Array
      expect(@enigma_1.key.key_digits).to eq ['0', '1', '2', '3', '4']
      expect(@enigma_1.key.a_shift).to eq 1
      expect(@enigma_1.key.b_shift).to eq 12
      expect(@enigma_1.offset).to be_a Offset
      expect(@enigma_1.offset.offset_digits).to be_a Array
      expect(@enigma_1.offset.offset_digits).to eq [7, 4, 0, 1]
    end

    it 'can take only message arg' do
      enigma.encrypt("Hello World!")

      expect(enigma.message).to eq(["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "!"])
      expect(enigma.key).to be_a Key
      expect(enigma.key.key_digits).to be_a Array
      expect('0'..'99').to include enigma.key.key_digits[0]
      expect(enigma.offset).to be_a Offset
      expect(enigma.offset.offset_digits).to be_a Array
      expect(0..9).to include enigma.offset.offset_digits[1]
    end

    it 'returns encrypted message' do
      expected = enigma.encrypt("Hello World!", "01234", "091299")

      expect(enigma.encrypt("Hello World!", "01234", "091299")).to be_a Hash

      expect("Hello World!".length).to eq expected[:encryption].length

      expect(expected[:encryption]).to eq "puhtwpswza !"
    end

    it 'returns error message if key is not a key' do
      expect(enigma.encrypt("Hello World!", "0134", "091299")).to be nil
    end

    it 'returns error message if date is not a date' do
      expect(enigma.encrypt("Hello World!", "01234", "09199")).to be nil
    end
  end

  describe '#decrypt' do
    it 'resets encrypted message to original' do
      message = "puhtwpswza !"
      decrypt_message = "hello world!"
      key = "01234"
      date = "091299"
      expect(enigma.decrypt(message, key, date)).to be_a Hash

      expect(enigma.decrypt(message, key, date).values).to include(decrypt_message)
      expect(enigma.decrypt(message, key, date).values).to include(date)
      expect(enigma.decrypt(message, key, date).values).to include(key)
    end
  end

  it 'checks if date is real' do
    expect(enigma.date_valid?("010199")).to be true

    expect(enigma.date_valid?("996400")).to be false
  end

  describe '#crack' do
    before(:each) do
      @enigma_2 = Enigma.new
      @decrypt_message = @enigma_2.encrypt("Hello World! end", "01234", "091299")[:encryption]
    end

    it 'returns hash' do
      expect(@enigma_2.crack(@decrypt_message)).to be_a Hash
    end

    it 'returns deciphered message downcased' do
      expect(@enigma_2.crack(@decrypt_message)[:decryption]).to eq "hello world! end"
    end
  end
end
