module Words
  module Frequencies
    class Ngram
      include Sampling
      attr_reader :order
      attr_accessor :gram_counts, :probabilities
      MAX_CHAIN_ORDER = 4

      def initialize(markov_order=2)
	raise "Ngram markov order too deep" unless markov_order <= MAX_CHAIN_ORDER
	@order = markov_order
	@gram_counts = {}
	@probabilities = {}

	@raw_counts = []
      end

      def gram_counts
	@gram_counts ||= {}
      end

      def aggregate_counts!(counts)
	# puts "--- aggregating counts"
	@gram_counts = counts.reduce({}) do |hsh,(k,v)|
	  hsh[k] ||= 0
	  hsh[k] = hsh[k] + v
	  hsh
	end
      end

      def process_groups(sentences)
	# puts "=== process text: #{sentences}"
	progress = ProgressBar.create(:title => "Process Text", :total => sentences.count)
	@raw_counts = Parallel.map(sentences, :in_processes => 32, :finish => lambda { |it,i,res| progress.increment }) do |line|
	  counts = []
	  words = line.is_a?(Array) ? line : line.split
	  words.each_cons(@order) { |v| counts << [v,1] }
	  counts
	end.flatten(1)

        process_counts(@raw_counts)	
      end

      def process_counts(counts)
	raise 'no data to process' unless counts && !counts.empty?
	aggregate_counts!(counts)
	normalize!
	gram_counts.sort_by { |k,_| k[0...-1] }
      end

      def merge(other_ngram)
	gram_counts.merge!(other_ngram.gram_counts) { |k, v1, v2| v1 + v2 }
      end


      def counts_for_series(series)
	return [] unless @sequences_attested.include?(series)
	@counts_for_series ||={}
        @counts_for_series[series] ||= @gram_counts.select { |k,_| k[0...-1] == series }
      end

      def select_for_series(arr, series)
	Hash[ arr.select { |k,_| k[0...-1] == series } ]
      end

      def probabilities_for_series(series)
	@probabilities_for_series ||= {}
	@probabilities_for_series[series] ||= select_for_series(@probabilities, series).map { |k,v| k = k.last; [k,v] }
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

      def sequences_attested
	raise 'no counts yet!' if @gram_counts.empty?
	@sequences_attested ||= @gram_counts.keys.map { |s| s[0...-1] }.sort.uniq
      end


      def normalize!
	progress = ProgressBar.create(:title => "Normalize", :total => sequences_attested.count)
	raw_probabilities = Parallel.map(sequences_attested, :in_processes => 32, :finish => lambda { |item, i, result| progress.increment }) do |series|
	  normalize_frequencies(counts_for_series(series))
	end

	# Parallel.each(raw_probabilities) { |k,v|
	#   @probabilities[k] ||= 0 
	# }
	puts "--- done normalizing!"
	@probabilities = raw_probabilities.reduce(&:merge)
      end
    end
  end
end
