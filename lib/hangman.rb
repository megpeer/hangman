class Game
  attr_accessor :word, :guess_word, :user_guess, :turn_count
  def initialize
    @word = ""
    @guess_word = ""
    @user_guess = ""
    @turn_count = 0
    puts "welcome to hangman!"
    pick_random_line
  end

  def pick_random_line
    @word =  File.readlines("google-10000-english-no-swears.txt").sample
    if @word.length > 12
      @word =  File.readlines("google-10000-english-no-swears.txt").sample
    # if @word.length < 5
    #   @word =  File.readlines("google-10000-english-no-swears.txt").sample
    else
    puts ""
    puts "the computer chose:\n#{@word}"
    @guess_word = @word.gsub(/\S/, '_')
    puts ""
    puts "the current guess is:\n#{@guess_word}"
    end
    guess_letter
    end
  

  def guess_letter
    @turn_count += 1
    puts ""
    puts "guess a letter:"
    @user_guess = gets.chomp
    puts ""
    puts "you guessed:"
    puts "#{@user_guess}"
    word_crunch
  end

  def word_crunch
  if @word.include?(@user_guess)
      puts ""
      puts "you guessed correct!"
      guessword_crunch
  else
      puts ""
      puts "you guessed incorrect!"
      guess_letter
  end
end

  def guessword_crunch
    index = @word.chars.each_with_index.select { |c, i| c == @user_guess }.map(&:last)
    puts index
    
    index.each_with_index {|o, i| @guess_word[o] = @user_guess}
    puts @guess_word
    guess_letter
  end


end

Game.new