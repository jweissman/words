module Words
  class Document # < TextSource
    include Frequencies
    include TextSource

    attr_reader :ngrams, :file, :title, :content, :sentences

    # note this affects performance like n!, so use cautiously
    # also quickly ends up just 'copying' the documents themselves, of course...
    MAX_NGRAM_DEPTH = 3

    def initialize(options={})
      @file       = options.delete(:file) { nil }
      @text       = options.delete(:text) { nil }
      @title      = title || file || 'untitled content'
      @max_ngram_depth = MAX_NGRAM_DEPTH

      read
      analyze
    end

    def analyze
      @sentences  = split(@content).map { |s| scrub(s) }
      @ngrams     = Array.new(@max_ngram_depth) do |order| 
	ngram = Ngram.new(order+1)
	ngram.process_groups(@sentences)
	ngram
      end
    end

    protected
    def read
      if @file 
	File.open(file) { |f| @content = f.read }
      elsif @text
	@content = @text
      else 
	raise "No content"
      end
    end

    def split(content=@content)
      return content if content.is_a?(Array) 
      content.split(/[\n.?!;-]/) 
    end

    def scrub(text)
      text = text.join(' ') if text.is_a?(Array)
      text.downcase.gsub(/[^a-z.-;!,' ]/, '')
    end
  end
end
