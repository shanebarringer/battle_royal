class Roll
  def initialize(player)
    turn(player)
  end

  def actions
    [:w00t, :blam, nil]
  end

  def turn(player)
    action = actions.sample
    !action.nil? ? player.send(action) : puts("#{player.name} missed a turn")
  end
end
