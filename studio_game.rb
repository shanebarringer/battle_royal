require_relative 'game'

throwdown = Game.new('throwdown')
throwdown.load_players(ARGV.shift || 'csv/favorite_players.csv')

loop do
  puts "\nHow many rounds would you like to play? (type 'quit' to exit)"
  rounds = gets.chomp.downcase
  case rounds
  when  /^\d+$/
    throwdown.play(rounds.to_i) { throwdown.total_points >= 3000 }
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
