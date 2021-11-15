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

    it 'returns a hash of proper length with keys when given only one argument' do
      expect(enigma.encrypt("Hello World!")).to be_a Hash
      expect(enigma.encrypt("Hello World!").count).to eq 3
      expect(enigma.encrypt("Hello World!").keys).to eq [:encryption, :key, :date]
    end

    it 'returns encrypted message' do
      expected = enigma.encrypt("Hello World!", "01234", "091299")

      expect(enigma.encrypt("Hello World!", "01234", "091299")).to be_a Hash

      expect("Hello World!".length).to eq expected[:encryption].length

      expect(expected[:encryption]).to eq "puhtwpswza !"
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

  describe 'it returns error messages if date and key are input incorrectly in encrypt and decrypt methods' do
    before(:each) do
      @enigma_1 = Enigma.new
    end

    specify {expect{(@enigma_1.encrypt("Hello World!", "0134", "091299"))}.to output.to_stdout}

    specify {expect{(@enigma_1.decrypt("Hello World!", "0134", "091299"))}.to output.to_stdout}

    specify {expect{(@enigma_1.encrypt("Hello World!", "01234", "09129"))}.to output.to_stdout}

    specify {expect{(@enigma_1.encrypt("Hello World!", "01234", "351920"))}.to output.to_stdout}

    specify {expect{(@enigma_1.decrypt("Hello World!", "01234", "09129"))}.to output.to_stdout}

    specify {expect{(@enigma_1.decrypt("Hello World!", "01234", "351920"))}.to output.to_stdout}

    specify {expect{(@enigma_1.encrypt("Hello World!", "0134", "091299"))}.to output(/That input is incorrect! Please input again/).to_stdout}

    specify {expect{(@enigma_1.decrypt("Hello World!", "0134", "091299"))}.to output(/That input is incorrect! Please input again/).to_stdout}

    specify {expect{(@enigma_1.encrypt("Hello World!", "01234", "09299"))}.to output(/That input is incorrect! Please input again/).to_stdout}

    specify {expect{(@enigma_1.decrypt("Hello World!", "01234", "09299"))}.to output(/That input is incorrect! Please input again/).to_stdout}

    specify {expect{(@enigma_1.encrypt("Hello World!", "01234", "351920"))}.to output(/That input is incorrect! Please input again/).to_stdout}

    specify {expect{(@enigma_1.decrypt("Hello World!", "01234", "351920"))}.to output(/That input is incorrect! Please input again/).to_stdout}
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
