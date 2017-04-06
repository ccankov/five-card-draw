require 'rspec'
require 'deck'

describe Deck do
  subject(:card_deck) { Deck.new }

  describe '#initialize' do
    it 'contains 52 cards' do
      expect(card_deck.deck.length).to eq(52)
    end
    it 'contains 13 cards of each suit' do
      SUITS = [:spades, :clubs, :hearts, :diamonds]
      SUITS.each do |suit|
        expect(card_deck.deck.select {|card| card.suit == suit }.length).to eq(13)
      end
    end

    it 'contains 4 cards of each value' do
      VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)
      VALUES.each do |value|
        expect(card_deck.deck.select {|card| card.value == value }.length).to eq(4)
      end
    end
  end

  describe '#deal_cards' do
    let(:hand) { double( { cards: [] }) }

    it 'adds cards to the hand until the hand has 5' do
      expect(hand.cards.length).to eq(0)
      card_deck.deal_cards(hand)
      expect(hand.cards.length).to eq(5)
    end

    it 'removes dealt cards from the deck' do
      expect(hand.cards.length).to eq(0)
      card_deck.deal_cards(hand)
      expect(card_deck.deck.length).to eq(47)
      hand.cards.each do |hand_card|
        expect(card_deck.deck).to_not include(hand_card)
      end
    end
  end

  describe '#shuffle_deck!' do

    it 'shuffles the cards without modifying them' do
      initial_deck = card_deck.deck.dup
      card_deck.shuffle_deck!
      expect(card_deck.deck).to_not eq(initial_deck)
      sorted_deck = card_deck.deck.sort_by { |card| card.suit.to_s + card.value.to_s }
      initial_sorted_deck = initial_deck.sort_by { |card| card.suit.to_s + card.value.to_s }
      expect(sorted_deck).to eq(initial_sorted_deck)
    end
  end
end
