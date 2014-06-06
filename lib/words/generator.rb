module Words
  # text generator designed to be compatible with either a doc or a corpus
  class Generator
    include Frequencies::Sampling
    MAX_WALK_DEPTH = 50

    attr_reader :source

    def initialize(src)
      @source = src
    end

    def word
      sample_frequencies(dictionary)
    end

    def sentence
      walk.join(' ').capitalize + '. '
    end

    def ngrams
      @source.ngrams
    end

    # probabilities for first-order n-grams across source
    def dictionary
      @dictionary ||= ngrams.first.probabilities 
    end

    def pick_initial
      @starting_gram_counts ||= @source.sentences.map(&:split).map(&:first).inject({}) do |hsh,w| 
	unless w.nil?
	hsh[w] ||= 0
	hsh[w] = hsh[w] + 1
	end
	hsh 
      end
      @starting_gram_probabilities ||= normalize_frequencies(@starting_gram_counts)
      sample_frequencies(@starting_gram_probabilities)
    end

    def pick(series)
      series = [series].flatten
      s = series[0..ngrams.size]

      grams = (ngrams-[ngrams.first]).map do |ngram|
	ns = s[-(ngram.order-1), ngram.order-1]
	ngram.get_options_and_probabilities(ns)
      end.reduce(&:merge) 

      if grams
	@options_and_probabilities ||= {}
	@options_and_probabilities[s] = grams
	@frequencies ||= {}
	@frequencies[series] ||= normalize_frequencies(@options_and_probabilities[s])
	sample_frequencies(@frequencies[series])
      end
    end

    def walk(opts={})
      depth = opts.delete(:depth) { MAX_WALK_DEPTH }
      start = pick_initial
      walk = [start]
      while walk.size < depth
        curr = pick_until_good(walk)
        break if !curr
        walk << curr 
      end
      walk
    end

    protected
    def pick_until_good(walk,cycle=false)
      p = pick(walk)
      good = good_choice?(p,walk,cycle)
      return p if good_choice?(p,walk,cycle)

      1_000.times do
	p = pick(walk)
	good = good_choice?(p,walk,cycle)
        break if good
      end

      return p if good
      nil
    end

    def good_choice?(word,series,cycle=false)
      !word.nil? && (cycle || !series.include?(word))
    end
  end
end
