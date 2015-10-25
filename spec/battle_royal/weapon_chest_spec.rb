require 'battle_royal/weapon_chest'
module BattleRoyal
  describe Weapon do
    before do
      @weapon = Weapon.new(:axe, 50)
    end

    it 'has a name attribute' do
      expect(@weapon.name).to eq(:axe)
    end

    it 'has a points attribute' do
      expect(@weapon.points).to eq(50)
    end
  end

  describe WeaponChest do
    it 'has six weapons' do
      expect(WeaponChest::WEAPONS.size).to eq(6)
    end

    it 'has a throwing_star worth 5 points' do
      expect(WeaponChest::WEAPONS[0]).to eq (Weapon.new(:throwing_star, 5))
    end

    it 'has a staff worth 25 points' do
      expect(WeaponChest::WEAPONS[1]).to eq (Weapon.new(:staff, 25))
    end

    it 'has a axe worth 50 points' do
      expect(WeaponChest::WEAPONS[2]).to eq (Weapon.new(:axe, 50))
    end

    it 'has a mace worth 100 points' do
      expect(WeaponChest::WEAPONS[3]).to eq (Weapon.new(:mace, 100))
    end

    it 'has a katana worth 200 points' do
      expect(WeaponChest::WEAPONS[4]).to eq (Weapon.new(:katana, 200))
    end

    it 'has a sabre worth 400 points' do
      expect(WeaponChest::WEAPONS[5]).to eq (Weapon.new(:sabre, 400))
    end
  end
end
