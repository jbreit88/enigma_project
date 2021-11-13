require './lib/offset'

RSpec.describe Offset do
  let(:offset) {Offset.new("090688")}

  it 'exists' do
    expect(offset).to be_a Offset
  end

  it 'has attributes' do
    expect(offset.date).to eq "090688"
    expect(offset.offset_digits).to eq [3, 3, 4, 4]
  end

  it 'squares the date' do
    expect(offset.square_date).to eq 8224313344
  end

  it 'gets last four digits from squared number' do
    expect(offset.offset_digits). to be_a Array

    expect(offset.offset_digits.length). to eq 4

    expect(offset.offset_digits[1]). to be_a Integer
  end

  it 'has hash of offset values' do
    expect(offset.offset_shifts).to be_a Hash
    expect(offset.offset_shifts).to eq({a_shift: 3, b_shift: 3, c_shift: 4, d_shift: 4})
  end
end
