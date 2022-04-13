require_relative 'gameplay.rb'
require 'yaml'

word_bank = File.read("google-10000-english-no-swears.txt").split(' ')

def game_begin(word_bank)
  game_selection = ''
  new_file_name = ''
  puts "Hello! Welcome to the classic one-on-one version of Hangman"
  puts "The computer makes up a word, you have to guess it!"
  puts "You have 7 guesses to get it right, otherwise, you lose!"
  
  if Dir.empty?('/Users/jeremiahkemp/TOP/hangman/saves')
   
    puts "What would you like to name this file?"
    new_file_name = gets.chomp
    "#{new_file_name}" = HangmanGameplay.new(word_bank)
    puts "Alright, lets play!"

  else
    
    until game_selection == 'c' || game_selection == 'n'
      puts "Do you want to do a new game or contiunue an older one ?  (N/n for new, C/c for continue"
      game_selection = gets.chomp.downcase
    end
      if game_selection == 'n'
        
        puts "What would you like to name this file?"
        new_file_name = gets.chomp
        "#{new_file_name}" = HangmanGameplay.new(word_bank)
        puts "Alright, lets play!"

      else

        puts "What file do you want to load?"
        saved_files = Dir.entries("saves")
        puts "#{saved_files}"
        chosen_file = gets.chomp
        YAML.load(File.read("saves/#{chosen_file}"))

      end
    end

end

game_begin(word_bank)

