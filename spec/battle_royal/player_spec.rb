require 'battle_royal/player'
require 'battle_royal/weapon_chest'

module BattleRoyal
  describe Player do
    before do
      # removes string output for power_up and damage methods while spec is running(only)
      $stdout = StringIO.new

      @initial_health = 150
      @player = Player.new('stryker', @initial_health)
    end

    def found_weapon
      @player.found_weapon(Weapon.new(:axe, 50))
    end
    it 'has a capitalized name' do
      expect(@player.name).to eq('Stryker')
    end

    it 'has an initial health' do
      expect(@player.health).to eq(150)
    end

    it 'has a string representation' do
      2.times { found_weapon }

      expect(@player.to_s).to eq('Stryker health = 150, points = 100, and score = 250')
    end

    it 'computes a score as the sum of its health and points' do
      2.times { found_weapon }

      expect(@player.score).to eq(250)
    end

    it 'increases health by 15 when power_uped' do
      @player.power_up
      expect(@player.health).to eq(@initial_health + 15)
    end

    it 'decreases health by 10 when damagemed' do
      @player.damage
      expect(@player.health).to eq(@initial_health - 10)
    end

    context 'player has health of 150' do
      before do
        @initial_health = 150
        @player = Player.new('stryker', @initial_health)
      end

      it 'returns true if player is strong' do
        expect(@player).to be_strong
      end
    end

    context 'player has health of 100 or less' do
      before do
        @initial_health = 99
        @player = Player.new('scorpion', @initial_health)
      end

      it 'returns false if player health is less 100 or less' do
        expect(@player).not_to be_strong
      end
    end
    context 'players collect weapons' do
      it 'computes points as the sum of all weapon points' do
        expect(@player.points).to eq(0)

        @player.found_weapon(Weapon.new(:axe, 50))

        expect(@player.points).to eq(50)

        @player.found_weapon(Weapon.new(:sabre, 400))

        expect(@player.points).to eq(450)

        @player.found_weapon(Weapon.new(:axe, 50))

        expect(@player.points).to eq(500)
      end
    end

    it 'yields each found weapon and its total points' do
      @player.found_weapon(Weapon.new(:mace, 100))
      @player.found_weapon(Weapon.new(:mace, 100))
      @player.found_weapon(Weapon.new(:axe, 50))
      @player.found_weapon(Weapon.new(:staff, 5))
      @player.found_weapon(Weapon.new(:staff, 5))
      @player.found_weapon(Weapon.new(:staff, 5))
      @player.found_weapon(Weapon.new(:staff, 5))
      @player.found_weapon(Weapon.new(:staff, 5))

      yielded = []
      @player.each_found_weapon do |weapon|
        yielded << weapon
      end

      expect(yielded).to eq([
        Weapon.new(:mace, 200),
        Weapon.new(:axe, 50),
        Weapon.new(:staff, 25)
      ])
    end
  end
end
