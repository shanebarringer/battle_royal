require_relative 'player'
require_relative 'roll'
require_relative 'weapon_chest'
require_relative 'lame_player'
require_relative 'advantaged_player'
require 'csv'
module BattleRoyal
  class Game
    attr_accessor :title, :players, :toasty
    def initialize(title)
      @title = title
      @players = [].sort
      @total_points = 0
      @toasty = []
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
      puts "There are #{@players.size} players and #{WeaponChest::WEAPONS.count} weapons available in this game: "

      WeaponChest::WEAPONS.each { |x| puts "A #{x.name} is worth #{x.points} points" }
    end

    def attack_player
      @players.sample
    end

    def fatality?(player)
      player.health < 0
    end

    def play(rounds)
      start_of_game
      1.upto(rounds) do
        # if a block is given AND the block returns true, break out of loop.
        break if yield if block_given?
        if @players.count > 1
          @players.shuffle.each do |player|
            if !fatality?(player)
              Roll.turn(player)
              sleep(0.5)
              player.attack(attack_player, player.found_weapon(Roll.weapon(player)))
              sleep(0.5)
              player.points
            elsif fatality?(player)
              @toasty << @players.find { |x| x == player }
              puts "\n#{player.name} is no longer with us"
              @players.delete(player)
              sleep(0.5)
            end
          end
        else
          puts "\n#{@players[0].name.upcase} IS THE LAST MAN STANDING!!! "
          break
        end
      end
      @players |= @toasty
    end

    def print_player_and_health(criteria)
      criteria.sort_by(&:score).reverse_each do |player|
        puts "\n#{player.name}'s point totals: "
        player.each_found_weapon do |weapon|
          puts "#{weapon.points} total #{weapon.name} points"
        end
        puts "#{player.points} grand total points"
        puts "health: #{player.health}"
      end
    end

    def result
      stronger, weaker = @players.partition(&:strong?)
      puts "\n Statistics:"

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
end
