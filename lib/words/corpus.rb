module Words
  class Corpus
    include Frequencies
    include TextSource

    attr_reader :ngrams, :files, :documents
    def initialize(files=[])
      @files = files
      process_text
    end

    def add(file) 
      @files << file
      process_text
    end

    def process_text
      @documents = @files.map { |f| Document.new(file: f) }
      @ngrams = Array.new(@documents.map(&:ngrams).flatten.map(&:order).max)
      analyze
    end

    def sentences; @sentence ||= @documents.map(&:sentences).flatten.uniq.sort end

    def analyze
      @documents.each do |doc|
	@ngrams.each_with_index do |ngram,i| 
	  @ngrams[i] ||= Ngram.new
	  @ngrams[i].merge(doc.ngrams[i] || {})
	end
      end

      @ngrams.each(&:normalize!)
    end
  end
end
