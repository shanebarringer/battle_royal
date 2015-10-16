require_relative 'advantaged_player'
module BattleRoyal
  describe AdvantagedPlayer do
    before do
      @initial_health = 50
      @player = AdvantagedPlayer.new('advantaged', @initial_health)
    end

    it 'does not go advantaged when power_uped up to 5 times' do
      1.upto(5) { @player.power_up }
      expect(@player.advantaged?).to be_falsey
    end

    it 'goes advantaged when power_uped more than 5 times' do
      1.upto(6) { @player.power_up }
      expect(@player.advantaged?).to be_truthy
    end

    it "gets power_uped instead of damagemed when it's gone advantaged" do
      1.upto(6) { @player.power_up }
      1.upto(2) { @player.damage }

      expect(@player.health).to be(@initial_health + (8 * 15))
    end
  end
end
