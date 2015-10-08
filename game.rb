require_relative 'player'
require_relative 'roll'

class Game
  attr_reader :title
  def initialize(title)
    @title = title
    @players = [].sort
  end

  def add_player(player)
    @players << player
  end

  def play(rounds)
    puts "There are #{@players.size} players in the game: "
    # @players.shuffle.each do |player|
    1.upto(rounds) do
      @players.shuffle.each do |player|
        puts "#{player.name} is rolling"
        # sleep(1)
        Roll.turn(player)
        # sleep(0.5)
        puts player
        # sleep(1)
      end
    end
  end

  def print_player_and_health(criteria)
    criteria.sort_by(&:score).reverse_each do |player|
      puts "#{player.name} (#{player.health})"
    end
  end

  def result
    stronger, weaker = @players.partition(&:strong?)
    puts "\n#{@title.capitalize} Statistics:"

    puts "\n#{stronger.size} strong players:"
    print_player_and_health(stronger)

    puts "\n#{weaker.size} weaker players:"
    print_player_and_health(weaker)
  end

  def winning
    puts "\nScoreboard: "
    @players.sort_by(&:score).reverse_each do |player|
      puts "#{player.name}...............#{player.score}"
    end
  end
end
