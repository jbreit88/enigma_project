require './lib/helpable'

RSpec.describe Helpable do
  let(:dummy_class) {Class.new {extend Helpable}}

  describe '#helper_methods' do
    it 'generates a 5 digit key' do
      require "pry"; binding.pry
      expect(dummy_class.generate_key).to be_a String
      expect(dummy_class.generate_key.length).to eq 5
      expect(0..99999).to cover dummy_class.generate_key.to_i
    end

    it "it returns today's date formatted for use" do
      expect(dummy_class.default_date).to be_a String
      expect(dummy_class.default_date.length).to eq 6

    end
  end

end
