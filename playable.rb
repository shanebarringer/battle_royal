module BattleRoyal
  module Playable
    def power_up
      self.health += 15
      puts "\n#{name} got a power up!"
    end

    def damage
      self.health -= 10
      puts "\n#{name} got damaged and now has a health of #{health}"
    end

    def strong?
      self.health >= 100
    end
  end
end
