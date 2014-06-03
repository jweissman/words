module Words
  module Frequencies
    class Ngram
      include Sampling
      attr_accessor :gram_counts, :probabilities
      MAX_CHAIN_ORDER = 36
      MAX_WALK_DEPTH = 60

      def initialize
	@gram_counts = {}
	@starting_gram_counts = {}
	@probabilities = {}
      end
      
      def pick_initial
        normalize! unless @normalized
        sample_frequencies(@starting_gram_probabilities)
      end

      def pick(series=[])
	series = [series].flatten!
	frequencies = probabilities_for_series(series)
	sample_frequencies(frequencies)
      end

      def pick_with_subseries(series,cycle=false)
	options = []
	subseries = series.clone
	while subseries && !subseries.empty?
	  options = options + get_options_for_series(subseries)
	  # curr = pick(subseries)
	  # options << curr if curr && (cycle || !series.include?(curr))
	  subseries.shift
	end

	result = options.uniq.sample
	if !cycle && series.include?(result)
	  attempts = 0
	  while series.include?(result) && attempts < 10
	    result = options.sample
	    attempts = attempts + 1
	  end
	end
	# result = options.sample while series.include?(result) && cycle # && series.include?(result)
	result

	# would be going for kind of a middle ground here: 
	# inverse sample *already likely* candidates from total appearances in corpus
	# counts = @gram_counts.select { |k,_| k.length == 1 && options.include?(k.first) }
	# sample_frequencies(normalize_frequencies(counts), invert: true)
      end

      def process(values)
	@starting_gram_counts[values.first] = (@starting_gram_counts[values.first]||0) + 1
	highest_order = [values.length,MAX_CHAIN_ORDER].min
	(1..highest_order).each do |n|
	  values.each_cons(n) do |v| 
	    @gram_counts[v] = (@gram_counts[v]||0) + 1
	  end
	end
      end

      def process_groups(grouped_values)
        grouped_values.each { |v| process(v) }
      end

      def merge(other_ngram)
	@gram_counts.merge!(other_ngram.gram_counts) { |k, v1, v2| v1 + v2 }
      end

      def walk(cycle=false,depth=MAX_WALK_DEPTH); random_walk(depth: depth, cycle: cycle) end

      protected

      def random_walk(opts={})
	depth = opts.delete(:depth) { MAX_WALK_DEPTH }
	cycle = opts.delete(:cycle) { false }
        start = pick_initial
	walk = [start]
	while walk.size < depth
	  curr = pick_with_subseries(walk,cycle)
	  break unless curr
	  walk << curr
	end
	walk
      end

      def select_for_series(arr, series)
	Hash[ arr.select { |k,_| k.length == series.length + 1 && k[0...-1] == series } ]
      end

      def counts_for_series(series)
	@counts_for_series ||= {}
	@counts_for_series[series] ||= select_for_series(@gram_counts, series)
	@counts_for_series[series]
      end

      def probabilities_for_series(series)
	normalize! unless @normalized
	@probabilities_for_series ||= {}
	@probabilities_for_series[series] ||= Hash[ select_for_series(@probabilities, series).map { |k,v| k = k.last; [k,v] } ]
      end

      def get_options_for_series(series)
	@options_for_series ||= {}
	@options_for_series[series] ||= counts_for_series(series).keys.map(&:last)
      end

      private

      def normalize!
	@probabilities ||= {}
	counts = @gram_counts.select { |k,_| k.length == 1 }
	normalize_frequencies(counts).each { |s,f| @probabilities[s] = f }
	@gram_counts.keys.group_by { |k| k.length }.each do |len,collection_of_keys|
	  print '!'
	  collection_of_keys.each do |series|
	    print ','
	    counts = counts_for_series(series)
	    normalize_frequencies(counts).each do |s,freq| 
	      print '.'
	      @probabilities[s] = freq 
	    end 
	  end
	end

	@starting_gram_probabilities = normalize_frequencies(@starting_gram_counts)
	@normalized = true
      end
    end
  end
end
