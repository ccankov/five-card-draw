require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'hand.rb'
require_relative 'player.rb'

class Game
  def initialize(players)
    @players = players
    raise 'Not enough players.' if @players.length < 2
    @current_pot = 0
    @deck = nil
  end

  def play
    play_round until game_over?
    puts "Game over! #{winner.name} is the last man standing."
  end

  def game_over?
    @players.count { |player| player.pot.zero? } == @players.length - 1
  end

  def winner
    raise 'Game is not over' unless game_over?
    @players.reject { |player| player.pot.zero? }.first
  end

  private

  def play_round
    round_players = @players.select { |player| player.pot > 0 }
    @deck = Deck.new
    bet_amt = 0
    @current_pot = 0
    round_players.each { |player| @deck.deal_cards(player.hand) }
    bet_amt, round_players = betting_phase(bet_amt, round_players)
    @players.rotate!
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
