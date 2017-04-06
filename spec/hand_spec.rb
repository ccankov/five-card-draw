require 'rspec'
require 'hand'


describe Hand do
  subject(:hand) {Hand.new}

  describe '#initialize' do
    it 'creates an empty hand' do
      expect(hand.cards).to be_empty
    end
  end

  context '#compute_hand' do
    let(:c3) { double(suit: :clubs, index: 1, value: '3') }
    let(:c5) { double(suit: :clubs, index: 3, value: '5') }
    let(:c6) { double(suit: :clubs, index: 4, value: '6') }
    let(:c7) { double(suit: :clubs, index: 5, value: '7') }
    let(:c8) { double(suit: :clubs, index: 6, value: '8') }
    let(:c9) { double(suit: :clubs, index: 7, value: '9') }
    let(:h7) { double(suit: :hearts, index: 5, value: '7') }
    let(:d7) { double(suit: :diamonds, index: 5, value: '7') }
    let(:s7) { double(suit: :spades, index: 5, value: '7') }
    let(:h6) { double(suit: :hearts, index: 4, value: '6') }

    it 'returns 0 and highest relevant value for straight flush' do
      [c5, c6, c7, c8, c9].each do |current_card|
        hand.cards << current_card
      end
      expect(hand.compute_hand).to eq([0, '9'])
    end
    it 'returns 1 and highest relevant value for four-of-a-kind' do
      [h7, d7, c7, s7, h6].each do |current_card|
        hand.cards << current_card
      end
      expect(hand.compute_hand).to eq(1, '7')
    end
    it 'returns 2 and highest relevant value for full house' do
      [h7, s7, c7, c6, h6].each do |current_card|
        hand.cards << current_card
      end
      expect(hand.compute_hand).to eq(2, '7')
    end
    it 'returns 3 and highest relevant value for flush' do
      [c3, c6, c7, c8, c9].each do |current_card|
        hand.cards << current_card
      end
      expect(hand.compute_hand).to eq(3, '9')
    end
    it 'returns 4 and highest relevant value for straight' do
      [c5, c6, h7, c8, c9].each do |current_card|
        hand.cards << current_card
      end
      expect(hand.compute_hand).to eq(4, '9')
    end
    it 'returns 5 and highest relevant value for three-of-a-kind' do
      [s7, h7, c7, c3, c9].each do |current_card|
        hand.cards << current_card
      end
      expect(hand.compute_hand).to eq([5, '7'])
    end
    it 'returns 6 and highest relevant value for two-pair' do
      [h6, c6, c7, h7, c9].each do |current_card|
        hand.cards << current_card
      end
      expect(hand.compute_hand).to eq(6, '7')
    end
    it 'returns 7 and highest relevant value for one-pair' do
      [h6, c6, c7, c3, c9].each do |current_card|
        hand.cards << current_card
      end
      expect(hand.compute_hand).to eq(7, '6')
    end
    it 'returns 8 and highest relevant value for no matching hand (high card)' do
      [c3, h6, d7, c8, c9].each do |current_card|
        hand.cards << current_card
      end
      expect(hand.compute_hand).to eq(8,'9')
    end
  end

  describe '#highest_value' do
    it 'returns the highest value of the hand' do

    end
  end
end
