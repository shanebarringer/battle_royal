require_relative 'game'

throwdown = BattleRoyal::Game.new('throwdown')
throwdown.load_players(ARGV.shift || 'csv/favorite_players.csv')
klutz = BattleRoyal::ClumsyPlayer.new('klutz', 105, 5)
throwdown.add_player(klutz)
berserker = BattleRoyal::BerserkPlayer.new('berserker', 50)
throwdown.add_player(berserker)

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
