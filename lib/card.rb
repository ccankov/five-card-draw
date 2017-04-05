class Card


  CARDS = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  attr_reader :index, :suit

  def initialize(index, suit)
    @index = index
    @suit = suit
  end

  def value
    CARDS[index]
  end

end
