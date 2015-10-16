require_relative 'player'
module BattleRoyal
  class LamePlayer < Player
    def initialize(name, health = 100, boost = 1)
      super(name, health)
      @boost = boost
    end

    def found_weapon(weapon)
      damaged_weapon = Weapon.new(weapon.name, weapon.points / 2)
      super(damaged_weapon)
    end

    def power_up
      @boost.times { super }
    end
  end

  if __FILE__ == $PROGRAM_NAME
    lame = LamePlayer.new('klutz')

    axe = Weapon.new(:axe, 50)
    lame.found_weapon(axe)
    lame.found_weapon(axe)
    lame.found_weapon(axe)

    sabre = Weapon.new(:sabre, 400)
    lame.found_weapon(sabre)

    lame.each_found_weapon do |weapon|
      puts "#{weapon.points} total #{weapon.name} points"
    end
    puts "#{lame.points} grand total points"
  end
end
