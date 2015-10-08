require_relative 'player'

describe Player do
  before do
    # removes string output for w00t and blam methods while spec is running(only)
    $stdout = StringIO.new

    @initial_health = 150
    @player = Player.new('larry', @initial_health)
  end

  it 'has a capitalized name' do
    expect(@player.name).to eq('Larry')
  end

  it 'has an initial health' do
    expect(@player.health).to eq(150)
  end

  it 'has a string representation' do
    expect(@player.to_s).to eq("I'm Larry with a health of 150 and a score of 155")
  end

  it 'computes a score and the sum of its health and length of name' do
    expect(@player.score).to eq(@initial_health + 5)
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
end
