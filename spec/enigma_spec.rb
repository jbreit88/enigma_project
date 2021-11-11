require './lib/enigma'
require './lib/key'

RSpec.describe Enigma do
  let(:enigma_1) {Enigma.new}

  it 'exists' do
    expect(enigma_1).to be_a Enigma
  end

  describe '#encrypt' do
    it 'takes three arguments' do
      expect(enigma_1.encrypt("Hello World!", "01234", "091299")).to eq []
    end

    it 'can take only message arg' do
      expect(enigma_1.encrypt("Hello World!")).to eq []
    end
  end

  # it 'has attributes' do
  #   expect(enigma_1.message).to eq "Hello World!"
  #
  #   expect(enigma_1.key).to be_a Key
  #   expect(enigma_1.key.key_digits).to eq "01234"
  #
  #   expect(enigma_1.date).to be_a String
  #   expect(enigma_1.date).to eq "091299"
  # end

  # it 'has default attribute values' do
  #   expected_key = enigma_2.key
  #   expect(enigma_2.message).to eq "Goodbye World!"
  #
  #   expect(enigma_2.key).to be_a Key
  #   expect(("0".."99999")).to cover enigma_2.key.key_digits
  #   expect(expected_key.key_digits.length).to eq 5
  #
  #   expect(enigma_2.date).to be_a String
  #   expect(enigma_2.date.length).to eq 6
  # end

  # describe '#check_date' do
  #   it 'returns true if real date' do
  #     expect(enigma_1.date_valid?('010293')).to be true
  #     # expect(enigma_1.date_valid?('341899')).to eq false
  #   end
  # end
end
