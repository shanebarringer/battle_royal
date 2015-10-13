require_relative 'game'

p1 = Player.new('moe')
p2 = Player.new('curly', 125)
p3 = Player.new('larry', 60)

throwdown = Game.new('throwdown')
throwdown.add_player(p1)
throwdown.add_player(p2)
throwdown.add_player(p3)
throwdown.play(10) { throwdown.total_points >= 2000 }
throwdown.result
throwdown.winning
