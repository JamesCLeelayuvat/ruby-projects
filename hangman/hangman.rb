class Game
  def initialize
    @guesses_left = 15
    @word = []
  end

  def get_word
    words = File.open("google-10000-english-no-swears.txt").read.split("\n").filter { |val| val.length >= 5 && val.length <= 12 ? true : false }.shuffle.pop.split("")
  end

  def disiplay_guesses_left
    puts "You have #{@guesses_left} guesses left!"
  end

  def display_guess
    @word_guessed.each do |letter|
      if letter.nil?
        print "_"
      else print letter       end
    end
  end

  def get_user_input
    puts
    puts "What's your guess?"
    input = gets.chomp
    input
  end

  def check_match(input)
    array_of_matches = []
    @word.each_with_index do |letter, index|
      if letter == input
        array_of_matches << index
      end
    end
    array_of_matches
  end

  def check_win?
    !@word_guessed.any? { |letter| letter.nil? }
  end

  def any_guesses_left?
    @guesses_left > 0
  end

  def start_game
    @word = get_word
    @word_guessed = Array.new(@word.size, nil)
    p @word
    while true
      disiplay_guesses_left
      display_guess
      input = get_user_input
      @guesses_left -= 1
      results = check_match(input)
      results.each { |index| @word_guessed[index] = input }
      if check_win?
        puts "You Won the Game!"
        break
      end
      if any_guesses_left? == false
        puts "You Lost the Game!"
        break
      end
    end
  end
end

hangman = Game.new
hangman.start_game
