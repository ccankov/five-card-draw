require 'rspec'
require 'player'

describe Player do
  subject(:player) { Player.new('Chris', 50_000) }

  describe '#initialize' do
    it 'creates a player with a name' do
      expect(player.name).to eq('Chris')
    end
    it 'creates a player with an empty hand' do
      expect(player.hand.cards).to be_empty
    end
    it 'creates a player with a pot' do
      expect(player.pot).to eq(50_000)
    end
  end

  describe '#move(bet_amt)' do
    it 'returns an array containing fold see or raise in index 0' do
      expect([:fold, :see, :raise]).to include(player.move[0])
    end
  end
end
