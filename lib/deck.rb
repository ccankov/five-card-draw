class Deck

  attr_reader :deck

  def initialize
    suits = [:spades, :clubs, :hearts, :diamonds]

    @deck = []
    suits.each do |suit|
      (0..12).each do |i|
        @deck << Card.new(i, suit)
      end
    end

  end

  def deal_cards(hand)
    until hand.cards.length == 5
      hand.cards << @deck.pop
    end
  end

  def shuffle_deck!
    @deck.shuffle!
  end

end
