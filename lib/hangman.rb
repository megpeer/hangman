require 'yaml'

class Game
  attr_accessor :word, :guess_word, :user_guess, :turn_count
  def initialize
    @word = ""
    @guess_word = ""
    @user_guess = ""
    @turn_count = 0
    @letter_guesses = []
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
    load_play
    end
  end

###ENTERING DANGER ZONE###

  def load_play
    puts ""
    puts "load saved game? (Y/N)"
    start = ""
    start = gets.upcase.chomp
  if start == "Y"
    from_yaml 
  else 
    guess_letter
    end
  end


  def save_game
    save_file = File.open("save_file.yml", "w")
    save_file.write to_yaml
    save_file.close
    puts ""
    puts "your last guess was:\n#{@guess_word}"
  end

  def to_yaml
    YAML.dump ({
        :word => @word,
        :guess_word => @guess_word,
        :turn_count => @turn_count,
        :letter_guesses => @letter_guesses
    })
  end

  def from_yaml
      yaml = YAML.load_file('save_file.yml')
      puts ""
      puts "saved game loading..."
      @word = yaml.fetch(:word)
      @guess_word = yaml.fetch(:guess_word)
      @turn_count = yaml.fetch(:turn_count)
      @letter_guesses = yaml.fetch(:letter_guesses)
      puts ""
      puts "your last guess was:\n#{@guess_word}"
      guess_letter
  end

###EXITING DANGER ZONE###

  def guess_letter
    if @guess_word == @word
      win
    elsif
      @turn_count == 15
      lose
    else
    @turn_count += 1
    puts ""
    puts "guess a letter:"
    @user_guess = gets.chomp
    end
    garbage_collect
  end

    def garbage_collect
      if @letter_guesses.include?(@user_guess)
        puts 'thats already been guessed.'
      else
        @letter_guesses.append(@user_guess)
      end
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
    save
  end

  def save
    puts "save game? (Y/N)"
    start = ""
    start = gets.upcase.chomp
    if start == "Y"
      save_game 
    else 
      guess_letter
    end
  end

  def win
    puts "you won."
  end

  def lose
    puts "you lost."
  end

end

Game.new