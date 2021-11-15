require './lib/translator'


RSpec.describe Translator do
  let(:character_set) {["a".."z"] << " "}
  let(:message) {"Hello World!"}
  let(:shift_values) {[1, 2, 3, 4]}
  let(:direction_1) {"forward"}
  let(:direction_2) {"backward"}
  let(:translator) {Translator.new(character_set, message, shift_values, direction_1)}

  it 'exists' do
    expect(translator).to be_a Translator
  end

  it 'has attributes' do
    expect(translator.character_set).to eq(['a'..'z'] << " ")
    expect(translator.message).to eq "Hello World!"
    expect(translator.shift_values).to eq([1, 2, 3, 4])
    expect(translator.direction).to eq "forward"
  end



end
