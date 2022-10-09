require_relative 'dict_manager.rb'

class Game 
    attr_accessor :words_filename
    attr_accessor :guess_word
    attr_accessor :remaining_attemts
    attr_accessor :guessed_letters

    def initialize(words_filename, guess_word = "", remaining_attemts = 10, guessed_letters = [])
        dict_manager = DictManager.new(words_filename)
        @guessed_letters = guessed_letters
        if guess_word.empty?
            @guess_word = dict_manager.rand_word 
        else 
            @guess_word = guess_word
        end
        @remaining_attemts = remaining_attemts
    end

    def print_status
        status = ""
        guess_word.split('').each do | letter |
            if guessed_letters.include?(letter)
                status.concat(letter)
            else 
                status.concat('_')
            end
        end
        return status
    end

    def over
        if @remaining_attemts == 0 
            return true
        end

        return false
    end

    def player_win
        return !print_status.include?('_')
    end


    def play
        welcome
    end
end