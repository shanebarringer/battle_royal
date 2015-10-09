module Roll
  def self.actions
    [:w00t, :blam, nil]
  end

  def self.turn(player)
    action = actions.sample
    !action.nil? ? player.send(action) : puts("#{player.name} missed a turn")
  end

  def self.treasure(player)
    treasure = TreasureTrove.random
    puts "#{player.name} found a #{treasure.name} worth #{treasure.points} points"
  end
end
