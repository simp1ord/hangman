require_relative 'saves.rb'

word_bank = File.read("google-10000-english-no-swears.txt").split(' ')

module GameplayFunctions

  protected


  def game_begin
    @game_selection = ''
    puts "Hello! Welcome to the classic one-on-one version of Hangman"
    puts "The computer makes up a word, you have to guess it!"
    puts "You have 7 guesses to get it right, otherwise, you lose!"
    if Dir.empty?('/Users/jeremiahkemp/TOP/hangman/saves')
      puts "Are you ready to play?"
      @game_selection = gets.chomp
      puts "Of course you are! Lets begin"
      self.word_selection()
    else
      while @game_selection != 'c' || @game_selection != 'n'
        puts "Do you want to do a new game or contiunue an older one ?  (N/n for new, C/c for continue"
        @game_selection = gets.chomp.downcase
      end
    end
  end

  def player_guess
    @guess = ''  
      while @guess.length != 1
        puts "Guess a letter."
        @guess = gets.chomp.downcase
      end
  end

  def guess_check
    @word_selected.each_with_index do |letter, index|
      if @guess == letter
        @guess_storage.delete_at(index)
        @guess_storage.insert(index, @guess)
      end
    end
  end

  def game_display
    @guessed_letters.push(@guess)
      @display_guesses = @guessed_letters.join()
      @visual_word = @guess_storage.join()
      puts "#{@visual_word} #{@display_guesses}"
  end

  def win_check
    @guess_word = @guess_storage.join('')
    @final_word = @word_selected.join('')
    if @guess_word == @final_word  
      puts "Congrats, you guessed #{@final_word} correctly!" 
      @win_game = true  
    end
  end
end


class HangmanGameplay
  include GameplayFunctions
  
  attr_reader :word_bank,
              :win_game
  attr_accessor :guess_storage,
                :game_selection,
                :word_selected,
                :guessed_letters,
                :game_rounds

  def initialize(word_bank)
    @@word_bank = word_bank
    @guessed_letters = []
    @win_game = false
    @guess_storage = []
    @game_selection = ''
    @word_selected = ''
    @game_rounds = 12
    self.game_begin()
  end

  protected

  def word_selection
    while (@word_selected.length < 5) || (@word_selected.length > 12)
    @word_selected = (@@word_bank.sample).split('')
    end
    @guess_storage = Array.new(@word_selected.length) {'_'}
    self.guess_word()
  end

  def guess_word
    while @game_rounds > 0 || @win_game == false
      puts "You have #{@game_rounds} guesses left!"
        self.player_guess()
        self.guess_check()
        self.game_display
        self.win_check()
        puts "Sorry, the word was #{@final_word}"
      @game_rounds -= 1
    end
    @final_word = @word_selected.join('')
    puts "Sorry, the word was #{@final_word}"
  end

end

new_game = HangmanGameplay.new(word_bank)
