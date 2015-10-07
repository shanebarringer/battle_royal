require_relative 'player'

class Game
  attr_reader :title
  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def actions
    [:w00t, :blam, nil]
  end

  def turn(player)
    action = actions.sample
    if !action.nil?
      player.send(action)
    else
      puts "#{player.name} missed a turn"
    end
  end

  def play
    puts "There are #{@players.size} players in the game: "
    @players.shuffle.each do |player|
      turn(player)
      puts player
    end
  end
end
