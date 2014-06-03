module Words
  class Corpus
    def initialize(docs=[])
      @documents = docs
      @ngrams = @documents.first.ngrams 
      @documents.each do |doc|
	next if doc == @documents.first
	@ngrams.merge(doc.ngrams)
      end
    end

    def word; @ngrams.pick end
    def sentence
      @ngrams.walk.join(' ').capitalize + '. '
    end
  end
end
