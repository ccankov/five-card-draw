class Player
  attr_reader :name, :hand, :pot

  def initialize(name, pot)
    @name = name
    @pot = pot
    @hand = Hand.new
  end

  def move(bet_amt)
    player_move = get_move(bet_amt)
    case player_move
    when 'f'
      [:fold]
    when 's'
      @pot -= bet_amt
      [:see]
    when 'r'
      raise_amt = handle_raise(bet_amt)
      @pot -= (raise_amt + bet_amt)
      [:raise, raise_amt]
    else
      raise 'Invalid move'
    end
  end

  def discard_cards
    puts 'You may discard and redraw up to 3 cards.'
    puts 'Indicate the indices of the cards you want to discard, if any.'
    choices = gets.chomp.split(',').map(&:to_i)
    choices.each do |delete_idx|
      @hand.cards.delete_at(delete_idx)
    end
  end

  private

  def handle_raise(bet_amt)
    puts "How much do you want to raise on top of #{bet_amt}?"
    raise_amt = gets.chomp.to_i
    raise 'Raise must be greater than 0.' if raise_amt <= 0
    raise 'Not enough in pot.' if raise_amt + bet_amt > @pot
    raise_amt
  end

  def get_move(bet_amt)
    puts "The current bet amount is #{bet_amt}."
    puts '(f)old/(s)ee/(r)aise'
    gets.chomp
  end
end
