module Words
  module Frequencies
    module Sampling
      def sample_frequencies(freq,opts={})
	inverse = opts.delete(:invert) { false }
	# puts "--- sampling..."
	value = rand
	selection = nil
	freq.each do |key, percent|
	  probability = percent/100.0
	  probability = (1.0/probability) if inverse
	  value = value - probability
	  selection = key
	  break if value <= 0
	end
	selection
      end

      # normalize a set of frequencies that may not total to 100%...
      def normalize_frequencies(freq)
	total = freq.map { |_,v| v }.reduce(&:+)
	remapped = freq.map { |k,v| [k, (v.to_f/total) * 100.0] }
	Hash[remapped]
      end
    end
  end
end
