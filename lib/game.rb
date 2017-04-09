require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'hand.rb'
require_relative 'player.rb'

class Game
  def initialize(players)
    @players = players
    raise 'Not enough players.' if @players.length < 2
    @current_bet = 0
    @deck = nil
  end

  def play
    @players.each do |player|
      @deck.deal_cards(player.hand)
    end


  end

  def game_over?
    @players.count <= 1
  end

  private

  def play_turn
    round_players = @players.select { |player| player.pot > 0 }
    bet_amt = 0
    bet_amt, round_players = betting_phase(bet_amt, round_players)
    collect_winnings(round_players.first) if round_players.length <= 1
    discard_phase(round_players)
    bet_amt, round_players = betting_phase(bet_amt, round_players)
    collect_winnings(round_players.first) if round_players.length <= 1
    showdown(round_players)
  end

  def betting_phase(bet_amt, players)
    no_raise_count = 0
    until no_raise_count == players.length
      players.each do |player|
        move = player.move
        case move[0]
        when :fold
          players.delete(player)
        when :see
          no_raise_count += 1
        when :raise
          bet_amt += move[1]
          no_raise_count = 1
        end
      end
    end
    [bet_amt, players]
  end

  def discard_phase(players)
    players.each do |player|
      player.discard_cards
      @deck.deal_cards(player.hand)
    end
  end
end
