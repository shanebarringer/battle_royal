require_relative 'treasure_trove'
require_relative 'playable'
module BattleRoyal
  class Player
    include Playable

    attr_accessor :name, :health
    def initialize(name, health = 100)
      @name = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end

    def to_s
      "#{@name} health = #{@health}, points = #{points}, and score = #{score}"
    end
    def self.from_csv(string)
      Player.new(string[0], string[1].to_i)
    end
    def found_treasure(treasure)
      @found_treasures[treasure.name] += treasure.points
      puts "#{@name} found a #{treasure.name} worth #{treasure.points} points"
      puts @found_treasures
    end

    def points
      @found_treasures.values.inject(0, :+)
    end

    def each_found_treasure
      @found_treasures.each do |name, points|
        yield Treasure.new(name, points)
      end
    end

    def score
      points + @health
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  # part of the readme
  player = Player.new('moe')
  puts player.name
  puts player.health
  player.w00t
  puts player.health
  player.blam
  puts player.health
end
