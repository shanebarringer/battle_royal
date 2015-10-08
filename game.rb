require_relative 'player'
require_relative 'roll'

class Game
  attr_reader :title
  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def play
    puts "There are #{@players.size} players in the game: "
    # @players.shuffle.each do |player|
    @players.each do |player|
      puts "#{player.name} is rolling"
      sleep(1)
      Roll.new(player)
      sleep(0.5)
      puts player
      sleep(1)
    end
  end
end
