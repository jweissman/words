module Words
  class Sampler
    def initialize(docs=[])
      @documents = docs
    end

    # def sentence
    #   result = ''
    #   fragments = (1..5).to_a.sample
    #   fragments.times do
    #     @documents.sample.sentence_fragment(last_word)
    #   end
    # end
  end
end
