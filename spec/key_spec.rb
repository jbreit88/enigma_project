require "./lib/key"

RSpec.describe Key do
  let(:key_1) {Key.new("01234")}
  let(:key_2) {Key.new}

  it 'exists' do
    expect(key_1).to be_a Key
  end

  it 'has attributes' do
    expect(key_1.key_digits).to be_a Array
    expect(key_1.key_digits.length).to eq 5
    expect(("0".."99999")).to cover key_1.key
  end

  it 'has attributes by default' do
    expect(key_2.key_digits).to be_a Array
    expect(key_2.key_digits.length).to eq 5
    expect(("0".."99999")).to cover key_2.key
  end

  describe '#shift methods' do
    it 'returns an integer' do
      expect(key_1.a_shift).to be_a Integer
      expect(key_1.a_shift).to eq 1

      expect(key_1.b_shift).to be_a Integer
      expect(key_1.b_shift).to eq 12

      expect(key_1.c_shift).to be_a Integer
      expect(key_1.c_shift).to eq 23

      expect(key_1.d_shift).to be_a Integer
      expect(key_1.d_shift).to eq 34
    end

    it 'has hash of shifts' do
      expect(key_1.key_shifts).to be_a Hash
      expect(key_1.key_shifts).to eq({a_shift: 1, b_shift: 12, c_shift: 23, d_shift: 34})
    end
  end
end
