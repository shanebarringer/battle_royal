require_relative 'player'
require_relative 'roll'
require_relative 'treasure_trove'
require 'csv'

class Game
  attr_reader :title
  def initialize(title)
    @title = title
    @players = [].sort
    @total_points = 0
  end

  def add_player(player)
    @players << player
  end

  def load_players(some_file)
    CSV.foreach(some_file).each do |line|
      add_player(Player.from_csv(line))
    end
  end

  def save_high_scores
    File.open("#{title}.txt", 'w') do |file|
      file.puts "#{@title} High Scores:"
      @players.sort_by(&:score).reverse_each do |player|
        file.puts sort_and_score(player)
      end
    end
  end

  def start_of_game
    puts "There are #{@players.size} players and #{TreasureTrove::TREASURES.count} treasures available in this game: "

    TreasureTrove::TREASURES.each { |x| puts "A #{x.name} is worth #{x.points} points" }
  end

  def play(rounds)
    start_of_game
    1.upto(rounds) do
      # if a block is given AND the block returns true, break out of loop.
      break if yield if block_given?
      @players.shuffle.each do |player|
        Roll.turn(player)
        player.found_treasure(Roll.treasure(player))
        player.points
      end
    end
  end

  def print_player_and_health(criteria)
    criteria.sort_by(&:score).reverse_each do |player|
      puts "\n#{player.name}'s point totals: "
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
      puts "#{player.points} grand total points"
    end
  end

  def result
    stronger, weaker = @players.partition(&:strong?)
    puts "\n#{@title.capitalize} Statistics:"

    puts "\n#{stronger.size} strong players:"
    print_player_and_health(stronger)

    puts "\n#{weaker.size} weaker players:"
    print_player_and_health(weaker)

    puts "\n#{total_points} total points for this match"
  end

  def winning
    puts "\nScoreboard: "
    @players.sort_by(&:score).reverse_each do |player|
      puts sort_and_score(player)
    end
  end

  def sort_and_score(player)
    formatted_name = player.name.ljust(20, '.')
    "#{formatted_name} #{player.score}"
  end

  def total_points
    @players.inject(0) { |sum, player| sum + player.points }
  end
end
