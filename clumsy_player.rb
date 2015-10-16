require_relative 'player'
module BattleRoyal
  class ClumsyPlayer < Player
    def initialize(name, health = 100, boost = 1)
      super(name, health)
      @boost = boost
    end

    def found_treasure(treasure)
      damaged_treasure = Treasure.new(treasure.name, treasure.points / 2)
      super(damaged_treasure)
    end

    def w00t
      @boost.times { super }
    end
  end

  if __FILE__ == $PROGRAM_NAME
    clumsy = ClumsyPlayer.new('klutz')

    hammer = Treasure.new(:hammer, 50)
    clumsy.found_treasure(hammer)
    clumsy.found_treasure(hammer)
    clumsy.found_treasure(hammer)

    crowbar = Treasure.new(:crowbar, 400)
    clumsy.found_treasure(crowbar)

    clumsy.each_found_treasure do |treasure|
      puts "#{treasure.points} total #{treasure.name} points"
    end
    puts "#{clumsy.points} grand total points"
  end
end
