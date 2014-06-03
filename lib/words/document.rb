module Words
  class Document
    include Frequencies
    attr_reader :ngrams, :file, :title, :content, :dictionary
    def initialize(file, title=nil)
      @file       = file
      @title      = title || file
      @ngrams     = Ngram.new

      analyze
    end

    def scrub(text)
      # text.downcase.gsub(/[^a-z ]/, ' ')
      text
    end

    def analyze
      raise 'No corpus given!' unless @file
      print "Building dictionary from file #@file..."
      File.open(@file) do |f|
	@content = f.read
	@sentences = @content.split(/[\n.?!]/) 
	@scrubbed_sentences = @sentences.map { |s| scrub(s) }
	@scrubbed_sentences.each do |scrubbed_sentence|
	  words = scrubbed_sentence.split
	  @ngrams.process(words)
	end
      end
    end

    def word
      @ngrams.pick
    end

    def sentence
      @ngrams.walk.join(' ').capitalize + '. ' 
    end
  end
end
