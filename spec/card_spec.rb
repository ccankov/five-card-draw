require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(12, :hearts) }

  describe '#initialize' do
    it 'sets the card\'s index' do
      expect(card.index).to eq(12)
    end
    it 'sets the card\'s suit' do
      expect(card.suit).to eq(:hearts)
    end
  end

  describe '#value' do
    it 'returns the corresponding value of the card' do
      expect(card.value).to eq("A")
    end
  end
end
