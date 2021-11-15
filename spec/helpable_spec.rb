require './lib/helpable'

RSpec.describe Helpable do
  let(:dummy_class) {Class.new {extend Helpable}}

  describe '#helper_methods' do
    it 'generates a 5 digit key' do
      expect(dummy_class.generate_key).to be_a String
      expect(dummy_class.generate_key.length).to eq 5
      expect(0..99999).to cover dummy_class.generate_key.to_i
    end

    it "it returns today's date formatted for use" do
      expect(dummy_class.default_date).to be_a String
      expect(dummy_class.default_date.length).to eq 6
    end

    it 'checks validity of date' do
      expect(dummy_class.date_valid?("010199")).to be true
      expect(dummy_class.date_valid?("311799")).to be false
    end

    describe '#error_message' do
      specify {expect{dummy_class.error_message}.to output.to_stdout}

      specify {expect{(dummy_class.error_message)}.to output(/That input is incorrect! Please input again/).to_stdout}

      specify {expect{(dummy_class.error_message)}.to_not output('').to_stdout}
    end

    describe '#total_shift' do
      it 'returns an array by merging two hashes and taking their values' do
        test_hash_1 = {a: 1, b: 2, c: 3}
        test_hash_2 = {a: 3, b: 2, c: 1}

        expect(dummy_class.total_shift(test_hash_1, test_hash_2)).to be_a Array
        expect(dummy_class.total_shift(test_hash_1, test_hash_2)).to eq [4, 4, 4]
      end
    end

    describe '#has retun methods' do
      it 'returns a hash with args set as values for encryption' do
        expect(dummy_class.return_encryption_hash("Hello", "1234", "5678")).to be_a Hash
        expect(dummy_class.return_encryption_hash("Hello", "1234", "5678")).to eq({encryption: "Hello", key: "1234", date: "5678"})
      end

      it 'returns a hash with args set as values for decryption' do
        expect(dummy_class.return_decryption_hash("Hello", "1234", "5678")).to be_a Hash
        expect(dummy_class.return_decryption_hash("Hello", "1234", "5678")).to eq({decryption: "Hello", key: "1234", date: "5678"})
      end

      it 'returns a hash with args set as values for cracking' do
        expect(dummy_class.return_cracked_hash("Hello", "1234", "5678")).to be_a Hash
        expect(dummy_class.return_cracked_hash("Hello", "1234", "5678")).to eq({decryption: "Hello", shift_values: "1234", date: "5678"})
      end
    end
  end

end
