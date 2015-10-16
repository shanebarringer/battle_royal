require_relative 'game'
module BattleRoyal
  describe Game do
    it 'computes total points as the sum of all player points' do
      $stdout = StringIO.new
      game = Game.new('knockout')

      player1 = Player.new('moe')
      player2 = Player.new('larry')

      game.add_player(player1)
      game.add_player(player2)

      player1.found_weapon(Weapon.new(:axe, 50))
      player1.found_weapon(Weapon.new(:axe, 50))
      player2.found_weapon(Weapon.new(:sabre, 400))

      expect(game.total_points).to eq(500)
    end
  end
end
