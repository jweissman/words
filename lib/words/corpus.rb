module Words
  class Corpus
    include Frequencies
    include TextSource

    attr_reader :ngrams
    def initialize(docs=[])
      puts "=== Created corpus!"
      @documents = docs
      @ngrams = Array.new(@documents.map(&:ngrams).flatten.map(&:order).max)
      
      analyze
    end

    def analyze
      @documents.each do |doc|
	@ngrams.each_with_index do |ngram,i| 
	  @ngrams[i] ||= Ngram.new
	  @ngrams[i].merge(doc.ngrams[i] || {})
	end
      end

      workers=[]
      @ngrams.each do |ngram|
	workers << Thread.new { ngram.postprocess }
      end

      workers.each(&:join)
    end
  end
end
