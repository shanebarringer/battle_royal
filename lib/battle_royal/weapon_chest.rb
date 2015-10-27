module BattleRoyal
  Weapon = Struct.new(:name, :points)

  module WeaponChest
    WEAPONS = [
      Weapon.new("throwing star".to_sym, 5),
      Weapon.new(:staff, 25),
      Weapon.new(:axe, 50),
      Weapon.new(:mace, 100),
      Weapon.new(:katana, 200),
      Weapon.new(:sabre, 400)
    ]

    def self.random
      WEAPONS.sample
    end
  end
end
