require_relative 'game'

puts 'Welcome to the Battle Royal. Please enter a name for the competition: '
name = gets.chomp.capitalize

throwdown = BattleRoyal::Game.new(name.empty? ? 'Throwdown' : name)
throwdown.load_players(ARGV.shift || 'csv/favorite_players.csv')
lame = BattleRoyal::LamePlayer.new('Stryker', 105, 5)
throwdown.add_player(lame)
awesome = BattleRoyal::AdvantagedPlayer.new('Scorpion', 120)
throwdown.add_player(awesome)
puts "#{throwdown.title} Begin!"
loop do
  puts "\nHow many rounds would you like to play? (type 'quit' to exit)"
  rounds = gets.chomp.downcase
  case rounds
  when  /^\d+$/
    throwdown.play(rounds.to_i) # { throwdown.total_points >= 10_000 }
  when  'quit', 'exit', 'n'
    throwdown.result
    throwdown.winning
    break
  else
    puts 'please enter a number'
    sleep(1)
  end
end

throwdown.save_high_scores
