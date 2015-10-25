require_relative 'player'
module BattleRoyal
  class AdvantagedPlayer < Player
    def initialize(name, health = 100)
      super(name, health)
      @power_up_count = 0
    end

    def advantaged?
      @power_up_count > 5
    end

    def power_up
      super
      @power_up_count += 1
      puts "#{@name} is advantaged!" if advantaged?
    end

    def damage
      advantaged? ? power_up : super
    end
  end

  if __FILE__ == $PROGRAM_NAME
    advantaged = AdvantagedPlayer.new('advantaged', 50)
    6.times { advantaged.power_up }
    2.times { advantaged.damage }
  end
end
