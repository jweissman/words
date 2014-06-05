module Words
  class Document # < TextSource
    include Frequencies
    include TextSource

    attr_reader :ngrams, :file, :title, :content

    # note this affects performance like n!, so use cautiously
    # also quickly ends up just 'copying' the documents themselves, of course...
    MAX_NGRAM_DEPTH = 5

    def initialize(options={}) #file, title=nil)
      @file       = options.delete(:file) { nil }
      @text       = options.delete(:text) { nil }
      @title      = title || file || 'untitled content'
      @max_ngram_depth = MAX_NGRAM_DEPTH

      read
      analyze
    end

    def analyze
      @ngrams     = Array.new(@max_ngram_depth) { |o| Ngram.new(o+1) }
      @sentences = split(@content).map { |s| scrub(s) }

      workers = []
      @ngrams.each do |ngram| 
	workers << Thread.new do
          @sentences.each do |line| 
            words = line.is_a?(Array) ? line : line.split
            ngram.process(words)
	  end
	  ngram.postprocess
	end
      end
      
      workers.each(&:join)
    end

    protected
    # def process_linesk
    #     s = scrub(sentence)
    #     process(s)
    #     s
    #   end
    # end

    private
    def read
      if @file 
	File.open(file) { |f| @content = f.read }
      elsif @text
	@content = @text
      else 
	raise "No content"
      end
    end

    def process(line)
      words = line.is_a?(Array) ? line : line.split
      @ngrams.each do |ngram| 
	ngram.process(words)
      end
    end

    def split(content=@content)
      return content if content.is_a?(Array) 
      content.split(/[\n.?!]/) 
    end

    def scrub(text)
      text = text.join(' ') if text.is_a?(Array)
      text.gsub(/[^a-z ]/, ' ')
    end
  end
end
