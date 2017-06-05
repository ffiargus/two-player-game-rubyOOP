class Player
  attr_reader :name
  attr_accessor :life

  def initialize(name)
    @name = name
    @life = 3
  end

  def lose_life
    @life -= 1
  end

end

class Question
  attr_reader :num1, :num2, :ans

  def initialize
    @num1 = rand(0..20)
    @num2 = rand(0..20)
    @ans = @num1 + @num2
  end
end

class Game
  @@question_num = 0
  attr_reader :q, :p1, :p2

  def initialize
    @q = []
    @p1 = Player.new('Player1')
    @p2 = Player.new('Player2')
    @current_player = @p1
  end

  def next_round
    @q[@@question_num] = Question.new
    return "#{@current_player.name}: What does #{@q[@@question_num].num1} plus #{@q[@@question_num].num2} equal?"
  end

  def calc(player_ans)
    if (player_ans.to_i == @q[@@question_num].ans)
      return 'You got it!'
    else
      @current_player.life -= 1
      return 'Seriously?? No!'
    end
  end

  def end_round
    @@question_num += 1
    toggle_player
    return "P1: #{@p1.life}/3 vs P2: #{@p2.life}/3"
  end

  private

  def toggle_player
    if @current_player == @p1
      @current_player = @p2
    else
      @current_player = @p1
    end
  end

end

play = Game.new

while (play.p1.life > 0) && (play.p2.life > 0)
  puts '----- NEW TURN -----'
  puts play.next_round
  print "> "
  choice = $stdin.gets.chomp
  puts play.calc(choice)
  puts play.end_round
end

puts '----- GAME OVER -----'
puts 'Good bye!'




