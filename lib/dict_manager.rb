class DictManager
    attr_accessor :filename  
    attr_accessor :rand_word 
    
    def initialize(filename)
        @filename = filename
        @dict = words_from_file(@filename)
        @rand_word = random_word(@dict)
    end

    def words_from_file(filename)
        words = []
        File.open(filename).readlines.each do | word | 
            words << word.strip
        end
        return select_words_by_length(words, 5, 10)
    end

    def select_words_by_length(words, min_length, max_length)
        words = words.select { | word | word.length >= min_length && word.length <= max_length }
        words
    end

    def random_word(words) 
        random_index = rand(0...words.length)
        words[random_index]
    end
end