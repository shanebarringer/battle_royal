module Roll
  def self.actions
    [:w00t, :blam, nil]
  end

  def self.turn(player)
    action = actions.sample
    !action.nil? ? player.send(action) : puts("#{player.name} missed a turn")
  end
end
