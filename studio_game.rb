require_relative 'game'

p1 = Player.new('moe')
p2 = Player.new('curly', 125)
p3 = Player.new('larry', 60)

throwdown = Game.new('throwdown')
throwdown.add_player(p1)
throwdown.add_player(p2)
throwdown.add_player(p3)

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
