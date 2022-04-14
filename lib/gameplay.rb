
require 'yaml'

module GameplayFunctions

  def load_game 
    File.open("#{@file_position}.yml", "w") do |file| 
      puts "What file do you want to load? Just type the name, not the .yml"
  saved_files = Dir.entries("saves")
  puts "#{saved_files}"
  chosen_file = gets.chomp
  game_file = YAML.load(File.read("saves/#{chosen_file}.yml"))
  chosen_file.guess_word()
  end

  protected

  def player_guess
    @guess = ''  
      until @guess.length == 1 || @guess == 'save'
        puts "Guess a letter. Or Type save to save this game."
        @guess = gets.chomp.downcase.gsub(/[^a-z ^A-Z]/, '')
      end
  end

  def guess_check
    if @guess == 'save'
      self.save_game()
    else
      @word_selected.each_with_index do |letter, index|
        if @guess == letter
          @guess_storage.delete_at(index)
          @guess_storage.insert(index, @guess)
          @game_rounds += 1
        end
      end
    end
  end

  def game_display
    @guessed_letters.push(@guess)
      @display_guesses = @guessed_letters.join()
      @visual_word = @guess_storage.join()
      puts "word : #{@visual_word} guessed letters : #{@display_guesses}"
  end

  def win_check
    @guess_word = @guess_storage.join('')
    @final_word = @word_selected.join('')
    if @guess_word == @final_word  
      puts "Congrats, you guessed #{@final_word} correctly!" 
      @win_game = true  
    end
  end

  def save_game
    @file_position = "saves/#{@file_name}"
    File.open("#{@file_position}.yml", "w") do |file| 
      YAML.dump(self, file)
    end
    game_end()
  end
  
  def game_end
    abort "Thanks for playing, rerun to continue!"
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

  def initialize(word_bank, new_file_name)
    @@word_bank = word_bank
    @guessed_letters = []
    @win_game = false
    @guess_storage = []
    @word_selected = ''
    @game_rounds = 12
    @file_name = new_file_name
    self.word_selection
  end

  def guess_word
    until @game_rounds == 0 || @win_game == true
      puts "You have #{@game_rounds} guesses left!"
        self.player_guess()
        self.guess_check()
        self.game_display
        self.win_check()
        @game_rounds -= 1
    end
    if @win_game != true
      @final_word = @word_selected.join('')
      puts "Sorry, the word was #{@final_word}"
    end
  end
  
  protected

  def word_selection
    while (@word_selected.length < 5) || (@word_selected.length > 12)
    @word_selected = (@@word_bank.sample).split('')
    end
    @guess_storage = Array.new(@word_selected.length) {'_'}
    self.guess_word()
  end


end
