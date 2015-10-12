require_relative 'player'
require_relative 'treasure_trove'

describe Player do
  before do
    # removes string output for w00t and blam methods while spec is running(only)
    $stdout = StringIO.new

    @initial_health = 150
    @player = Player.new('larry', @initial_health)
  end

  def found_treasure
    @player.found_treasure(Treasure.new(:hammer, 50))
  end
  it 'has a capitalized name' do
    expect(@player.name).to eq('Larry')
  end

  it 'has an initial health' do
    expect(@player.health).to eq(150)
  end

  it 'has a string representation' do
    2.times { found_treasure }

    expect(@player.to_s).to eq('Larry health = 150, points = 100, and score = 250')
  end

  it 'computes a score as the sum of its health and points' do
    2.times { found_treasure }

    expect(@player.score).to eq(250)
  end

  it 'increases health by 15 when w00ted' do
    @player.w00t
    expect(@player.health).to eq(@initial_health + 15)
  end

  it 'decreases health by 10 when blammed' do
    @player.blam
    expect(@player.health).to eq(@initial_health - 10)
  end

  context 'player has health of 150' do
    before do
      @initial_health = 150
      @player = Player.new('larry', @initial_health)
    end

    it 'returns true if player is strong' do
      expect(@player).to be_strong
    end
  end

  context 'player has health of 100 or less' do
    before do
      @initial_health = 99
      @player = Player.new('moe', @initial_health)
    end

    it 'returns false if player health is less 100 or less' do
      expect(@player).not_to be_strong
    end
  end
  context 'players collect treasures' do
    it 'computes points as the sum of all treasure points' do
      expect(@player.points).to eq(0)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eq(50)

      @player.found_treasure(Treasure.new(:crowbar, 400))

      expect(@player.points).to eq(450)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eq(500)
    end
  end

  it 'yields each found treasure and its total points' do
    @player.found_treasure(Treasure.new(:skillet, 100))
    @player.found_treasure(Treasure.new(:skillet, 100))
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))

    yielded = []
    @player.each_found_treasure do |treasure|
      yielded << treasure
    end

    expect(yielded).to eq([
      Treasure.new(:skillet, 200),
      Treasure.new(:hammer, 50),
      Treasure.new(:bottle, 25)
    ])
  end
end
