class Board
  def initialize
  end

  public

  def play_game(player1, player2)
    @array = [["", "", ""],
              ["", "", ""],
              ["", "", ""]]
    winner = "NONE"
    play_count = 0
    while winner == "NONE"
      if play_count % 2 == 0
        puts "Player 1"
        play(player1)
      else
        puts "Player 2"
        play(player2)
      end
      play_count += 1
      winner = check_win
      p check_win
      showBoard
    end
    puts winner + " won!"
  end

  private

  def play(player_mark)
    invalid_input = true
    while invalid_input
      puts "Which row?"
      row = gets.to_i
      puts "Which column?"
      column = gets.to_i
      puts "Hello!"
      if row.between?(1, 3) && column.between?(1, 3) && @array[row - 1][column - 1] == ""
        puts "Hi!"
        invalid_input = false
        @array[row - 1][column - 1] = player_mark
      else
        puts "Invalid input!"
      end
    end
  end

  def check_win
    3.times do |i|
      if @array[i][0] == @array[i][1] && @array[i][2]
        return @array[i][0]
      end
      if @array[0][i] == @array[1][i] && @array[2][i]
        return @array[i][i]
      end
    end
    if @array[0][0] == @array[1][1] && @array[0][0] == @array[2][2]
      return @array[0][0]
    end
    if @array[0][2] == @array[1][1] && @array[0][2] == @array[2][0]
      return @array[0][2]
    end
    return "NONE"
  end

  def showBoard
    @array.each do |rows|
      rows.each do |i|
        print i + "|"
      end
      puts
      puts "-----------"
    end
  end
end

new_board = Board.new
new_board.play_game("X", "O")
