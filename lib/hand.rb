class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def compute_hand
    raise 'Hand does not have 5 cards' unless @cards.length == 5
    card_counts = count_cards
    return [8, card_counts.keys.last] if flush? && straight?
    return [7, card_counts.key(4)] if card_counts.values.max == 4
    return [6, card_counts.key(3)] if card_counts.keys.size == 2
    return [5, card_counts.keys.max] if flush?
    return [4, card_counts.keys.max] if straight?
    return [3, card_counts.key(3)] if card_counts.values.max == 3
    if card_counts.values.max == 2 && card_counts.keys.count == 3
      pairs = card_counts.reject { |_, count| count == 1 }
      return [2, pairs.keys.max]
    end
    return [1, card_counts.key(2)] if card_counts.values.max == 2
    [0, card_counts.keys.max]
  end

  def self.highest_value(*hands)
    organized_hands = hands.sort_by do |hand|
      [hand.compute_hand[0], hand.compute_hand[1]]
    end
    organized_hands.last
  end

  private

  def flush?
    @cards.all? { |card| card.suit == @cards[0].suit }
  end

  def straight?
    sorted_cards = @cards.sort_by(&:index)
    (1...@cards.length).each do |i|
      return false unless sorted_cards[i].index - 1 == sorted_cards[i - 1].index
    end
    true
  end

  def count_cards
    value_counts = Hash.new(0)
    sorted_cards = @cards.sort_by(&:index)
    sorted_cards.each do |card|
      value_counts[card.index] += 1
    end
    value_counts
  end

  def display_cards
    p @cards.map(&:to_s)
  end
end
