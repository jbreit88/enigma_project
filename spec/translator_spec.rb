require './lib/translator'


RSpec.describe Translator do
  let(:character_set) {("a".."z").to_a << " "}
  let(:message_1) {"Hello World!"}
  let(:message_2) {"puhtwpswza !"}
  let(:key) {"01234"}
  let(:date) {"091299"}
  let(:direction_1) {1}
  let(:direction_2) {-1}
  let(:translator_1) {Translator.new(character_set, message_1, key, date, direction_1)}

  let(:translator_2) {Translator.new(character_set, message_2, key, date, direction_2)}

  it 'exists' do
    expect(translator_1).to be_a Translator
  end

  it 'has attributes' do
    expect(translator_1.character_set).to be_a Array
    expect(translator_1.character_set).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "])
    expect(translator_1.message).to eq (['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', '!'])
    expect(translator_1.key).to be_a Key
    expect(translator_1.key.key_digits).to be_a Array
    expect(translator_1.key.key_digits).to eq(['0', '1', '2', '3', '4'])
    expect(translator_1.key.a_shift).to eq 1
    expect(translator_1.key.b_shift).to eq 12
    expect(translator_1.offset).to be_a Offset
    expect(translator_1.offset.offset_digits).to be_a Array
    expect(translator_1.offset.offset_digits).to eq [7, 4, 0, 1]
    expect(translator_1.date).to eq "091299"
    expect(translator_1.shift_values).to eq(nil)
    expect(translator_1.direction).to eq 1
  end

  describe '#get_rotation_from_index' do
    it 'divides index number by length of array to indicate which shift alphabet to use' do
      translator_dummy = Translator.new('1', '2', '32344', '121299', 1)

      translator_dummy.instance_variable_set(:@shift_values, [1, 2, 3, 4])

      expect(translator_dummy.get_rotation_from_index(0)).to eq 0
      expect(translator_dummy.get_rotation_from_index(1)).to eq 1
      expect(translator_dummy.get_rotation_from_index(2)).to eq 2
      expect(translator_dummy.get_rotation_from_index(4)).to eq 0
      expect(translator_dummy.get_rotation_from_index(5)).to eq 1
    end
  end

  describe '#translate' do
    it 'returns information hash for encryption when direction is encrypt' do
      expect(translator_1.translate).to be_a Hash
      expect(translator_1.translate.count).to eq 3
      expect(translator_1.translate.keys).to eq([:encryption, :key, :date])
    end

    it 'returns complete hash for encrypt' do
      expect(translator_1.translate).to eq({:encryption=>"puhtwpswza !", :key=>"01234", :date=>"091299"})
    end

    it 'returns information hash for decryption when direction is decrypt' do
      expect(translator_2.translate).to be_a Hash
      expect(translator_2.translate.count).to eq 3
      expect(translator_2.translate.keys).to eq([:decryption, :key, :date])
    end

    it 'returns complete hash for decrypt' do
      expect(translator_2.translate).to eq({:decryption=>"hello world!", :key=>"01234", :date=>"091299"})
    end
  end
end
