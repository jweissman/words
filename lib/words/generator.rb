module Words
  class Generator
    include Frequencies::Sampling
    MAX_WALK_DEPTH = 20

    attr_reader :source

    def initialize(source)
      @source = source
    end

    def word
      # puts "=== sampling dictionary"
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
      # puts "--- generating dictionary"
      # unless @dictionary
      #   ngrams.first.normalize! unless ngrams.first.normalized
      # end
      @dictionary ||= ngrams.first.probabilities 
    end

    def pick(series)
      series.flatten!
      # puts "--- Attempting to pick a word based on existing series: #{series}"
      s = series[0..ngrams.size]
      # puts "--- Considering #{s}"
      grams = ngrams[s.size]
      if grams
	frequencies = grams.get_options_and_probabilities(s)
	# puts "--- frequencies: #{frequencies.inspect}"
	w = sample_frequencies(normalize_frequencies(frequencies))
	# puts "--- Chose: #{w}"
	w
      end
    end

    def walk(opts={})
      # puts "=== WALK opts=#{opts.inspect}"
      depth = opts.delete(:depth) { MAX_WALK_DEPTH }
      cycle = opts.delete(:cycle) { false }

      # use the order-1 chain to pick starting point
      start =  word #@source.ngrams[1].pick_initial
      binding.pry if start.nil?
      raise "Could not find a good starting point" if start.nil?
      walk = [start]
      curr = nil
      while walk.size < depth
	# puts "--- walk so far: #{walk}"
	curr = pick(walk)
	attempts,max_attempts = 0,40
        curr = pick(walk) until good_choice?(curr,walk,cycle) || (attempts=attempts+1)>max_attempts
        break unless curr
        walk << curr
      end
      walk
    end

    protected
    def good_choice?(word,series,cycle=false)
      # puts "--- is '#{word}' a good choice for series? (cycle=#{cycle})"
      good = !(word.nil? || (!cycle && series.include?(word)))
      # puts "--- #{good}"
      good # || nil
    end
  end
end
