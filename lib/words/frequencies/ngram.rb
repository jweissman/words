module Words
  module Frequencies
    class Ngram
      include Sampling

      attr_reader :order
      attr_accessor :gram_counts, :probabilities, :starting_gram_counts

      MAX_CHAIN_ORDER = 7

      # 
      # interesting -- i could refactor this to *take* an order, and then build ngrams of arbitrary-orders...
      #
      # a little worrying because i know i rely so heavily on being able to find 'shorter' chains in various ways
      # but this is kind of suggesting that this class anyway is the wrong 'abstraction layer' to do that in
      # maybe that's "document" level stuff? we can move the random walk stuff there, that kind of makes sense anyway?
      #
      def initialize(markov_order=2)
	raise "Ngram markov order too deep" unless markov_order <= MAX_CHAIN_ORDER

	@order = markov_order
	# @gram_counts = {}
	@starting_gram_counts = {}
	# @probabilities = {}

	# puts "=== Created new ngram of order #{markov_order}"
      end
      
      def pick_initial
        raise 'NOT NORMALIZED' unless @normalized
        sample_frequencies(@starting_gram_probabilities)
      end

      def probabilities
	raise 'NOT NORMALIZED' unless @normalized
	@probabilities ||= {}
      end

      def gram_counts
	@gram_counts ||= {}
      end

      def process(values)
	first = if values.is_a?(String) then values else values.first end
	@gram_counts ||= {}
	@starting_gram_counts[first] = (@starting_gram_counts[first]||0) + 1
	values.each_cons(@order) do |v| 
	  @gram_counts[v] = (gram_counts[v]||0) + 1
	end
      end

      def postprocess
	normalize!
	@gram_counts.sort_by { |k,_| k[0...-1] }
      end

      def process_groups(grouped_values)
        grouped_values.each { |v| process(v) }
      end

      def merge(other_ngram)
	gram_counts.merge!(other_ngram.gram_counts) { |k, v1, v2| v1 + v2 }
      end


      def select_for_series(arr, series)
	Hash[ arr.select { |k,_| k[0...-1] == series } ]
      end

      def counts_for_series(series)
	@counts_for_series ||={}
        @counts_for_series[series] ||= @gram_counts.select { |k,_| k[0...-1] == series }
      end
      #   @counts_for_series ||= {}
      #   @counts_for_series[series] ||= Hash[ @gram_counts.select { |k,_| k[0...-1] == series ] # select_for_series(@gram_counts, series)
      #   @counts_for_series[series]
      # end

      def probabilities_for_series(series)
	normalize! unless @normalized
	@probabilities_for_series ||= {}
	@probabilities_for_series[series] ||= Hash[ select_for_series(@probabilities, series).map { |k,v| k = k.last; [k,v] } ]
      end

      def get_options_for_series(series)
	@options_for_series ||= {}
	@options_for_series[series] ||= counts_for_series(series).keys.map(&:last)
      end

      def get_options_and_probabilities(series)
	Hash[
	  probabilities_for_series(series).map do |k,v|
	    [k.is_a?(Array) ? k.last : k, v]
	  end
	]
      end

      private

      # this is not reasonable for large data sets! it's like n! or something, at least n^3
      # i think it's no longer factorial after restricting the order of the chain to be consistent
      def normalize!
	@probabilities ||= {}
	keys = @gram_counts.keys.map { |series| series[0...-1] }.uniq # .each do |series, _| # collection_of_keys|
	puts "--- processing #{keys.count} keys..."
	keys.each_with_index do |series, n|
	  print '.' if n%100 == 0
	  counts = counts_for_series(series)
	  normalize_frequencies(counts).each { |s,freq| @probabilities[s] = freq }
	end

	puts "--- normalizing starting grams" # TODO bring this up to doc/corpus, it just over-complicates us here...
	@starting_gram_probabilities = normalize_frequencies(@starting_gram_counts)
	@normalized = true
      end
    end
  end
end
