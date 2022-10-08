require_relative 'dict_manager.rb'

words_filename = 'google-10000-english-no-swears.txt'

class Game 
    attr_accessor :words_filename
    attr_accessor :guess_word
    attr_accessor :remaining_attemts

    def initialize(words_filename, guess_word = "", remaining_attemts = 10)
        dict_manager = DictManager.new(words_filename)
        if guess_word.empty?
            @guess_word = dict_manager.rand_word 
        else 
            @guess_word = guess_word
        end
        @remaining_attemts = remaining_attemts
    end

end

game = Game.new(words_filename)
game2 = Game.new(words_filename, guess_word = "valves", remaining_attemts = 9)

# puts game.guess_word
# puts "#{game2.guess_word} #{game2.remaining_attemts}"



