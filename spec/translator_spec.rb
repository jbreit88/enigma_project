require './lib/translator'


RSpec.describe Translator do
  let(:translator) {Translator.new(charcter_set, message, shift_values, direction)}

  it 'exists' do
    expect(translator).to be_a Translator
  end



end
