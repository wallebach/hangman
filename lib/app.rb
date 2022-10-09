require_relative 'game.rb'

words_filename = 'google-10000-english-no-swears.txt'

class App 
    attr_accessor :game
    attr_accessor :words_filename

    def initialize(words_filename)
        @words_filename = words_filename
        @saved_dir = 'saved'
        @saved_file = 'game.txt'
        @saved_path = "#{@saved_dir}/#{@saved_file}"
    end

    def load_game 
        if Dir.exist?(@saved_dir)
            saved_data = File.readlines(@saved_path).first.chomp.split
            guessed_letters = File.readlines(@saved_path).last.chomp.split
            game = Game.new(words_filename, saved_data[0], saved_data[1].to_i, guessed_letters) 
        else
            puts "No game saved. Starting new game."
            game = Game.new(words_filename)
        end

        game
    end

    def save_game(guess_word, remaining_attemts, guessed_letters)
        Dir.mkdir(@saved_dir) unless Dir.exist?(@saved_dir)
        File.open(@saved_path, 'w') do | file |
            file.puts "#{guess_word} #{remaining_attemts}"
            file.puts "#{guessed_letters.join(' ')}"
        end
    end

    def play
        puts "WELCOME"
        game = select_game
        game_loop(game)
    end
    
    private
    
    def game_loop(game)
        end_of_game = false
        until end_of_game do
            puts game.print_status
            input = gets.chomp
            if input == 'save'
                save_game(game.guess_word, game.remaining_attemts, game.guessed_letters)
                end_of_game = true
            elsif game.guess_word.include?(input) && !game.guessed_letters.include?(input)
                game.guessed_letters << input
            else
                game.remaining_attemts -= 1 
            end
            
            if game.player_win
                puts "PLAYER WINS"
                end_of_game = true
            elsif game.over
                puts "GAME OVER :("
                end_of_game = true
            end 
        end

    end

    def select_game
        puts "Press 1 for new game"
        puts "Press any key to load game" unless !File.exist?(@saved_path)

        choice = gets.chomp

        case choice
        when "1"
            game = Game.new(@words_filename)
        else 
            game = load_game
        end

        return game
    end
end

app = App.new(words_filename)
app.play
