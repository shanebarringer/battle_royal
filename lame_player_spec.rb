require_relative 'lame_player'
module BattleRoyal
  describe LamePlayer do
    before do
      @player = LamePlayer.new('klutz')
    end

    it 'only gets half the point value for each weapon' do
      expect(@player.points).to eq(0)

      axe = Weapon.new(:axe, 50)
      @player.found_weapon(axe)
      @player.found_weapon(axe)
      @player.found_weapon(axe)

      expect(@player.points).to eq(75)

      sabre = Weapon.new(:sabre, 400)
      @player.found_weapon(sabre)

      expect(@player.points).to eq(275)

      yielded = []
      @player.each_found_weapon do |weapon|
        yielded << weapon
      end

      expect(yielded).to eq([Weapon.new(:axe, 75), Weapon.new(:sabre, 200)])
    end
  end
end
