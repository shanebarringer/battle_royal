module BattleRoyal
  module Roll
    def self.actions
      [:w00t, :blam, nil]
    end

    def self.turn(player)
      action = actions.sample
      !action.nil? ? player.send(action) : puts("#{player.name} missed a turn")
    end

    def self.treasure(_player)
      TreasureTrove.random
    end
  end
end
