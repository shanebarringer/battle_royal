module BattleRoyal
  module Roll
    def self.actions
      [:power_up, :damage, nil]
    end

    def self.turn(player)
      action = actions.sample
      !action.nil? ? player.send(action) : puts("\n#{player.name} missed a turn")
    end

    def self.weapon(_player)
      WeaponChest.random
    end
  end
end
