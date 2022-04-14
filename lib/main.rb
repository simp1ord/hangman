require_relative 'gameplay.rb'
require 'yaml'

word_bank = File.read("google-10000-english-no-swears.txt").split(' ')

def game_begin(word_bank)
  game_selection = ''
  new_file_name = ''

  rules_and_options()
  
  if Dir.empty?('/Users/jeremiahkemp/TOP/hangman/saves')
    create_new_file(word_bank)
  else
    
    until game_selection == 'c' || game_selection == 'n'
      puts "Do you want to do a new game or contiunue an older one ?  (N/n for new, C/c for continue"
      game_selection = gets.chomp.downcase
    end
      if game_selection == 'n'
        create_new_file(word_bank)
      else
        load_old_file()
      end
    end

end


def load_old_file(word_bank)
  puts "What do you want to rename your old loaded file?"
  new_file_name = gets.chomp
  old_file = HangmanGameplay.new(word_bank, new_file_name)
end

def create_new_file(word_bank)
  puts "What would you like to name this file?"
        new_file_name = gets.chomp
        new_file_name = HangmanGameplay.new(word_bank, new_file_name)
        puts "Alright, lets play!"
end

def rules_and_options
  puts "Hello! Welcome to the classic one-on-one version of Hangman"
  puts "The computer makes up a word, you have to guess it!"
  puts "You have 7 guesses to get it right, otherwise, you lose!"
end

game_begin(word_bank)

