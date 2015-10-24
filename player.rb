require_relative 'weapon_chest'
require_relative 'playable'
module BattleRoyal
  class Player
    include Playable

    attr_accessor :name, :health
    def initialize(name, health = 100)
      @name = name.capitalize
      @health = health
      @found_weapons = Hash.new(0)
    end

    def to_s
      "#{@name} health = #{@health}, points = #{points}, and score = #{score}"
    end

    def self.from_csv(string)
      Player.new(string[0], string[1].to_i)
    end

    def found_weapon(weapon)
      @found_weapons[weapon.name] += weapon.points
      print "\n#{@name} found a #{weapon.name} worth #{weapon.points} damage points"

      @found_weapons[weapon.name]
    end

    def attack(player, found_weapon)
      @health = health - found_weapon
      print " and attacked #{player.name} \n"
      puts "#{player.name}'s health is now: #{player.health} \n"
    end

    def points
      @found_weapons.values.inject(0, :+)
    end

    def each_found_weapon
      @found_weapons.each do |name, points|
        yield Weapon.new(name, points)
      end
    end

    def score
      points + @health
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  # part of the readme
  player = Player.new('Scorpion')
  puts player.name
  puts player.health
  player.power_up
  puts player.health
  player.damage
  puts player.health
end
