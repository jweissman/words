require 'parallel'

require 'words/version'
require 'words/frequencies/sampling'
require 'words/frequencies/letters'
require 'words/frequencies/bigrams'
require 'words/frequencies/ngram'
require 'words/text_helpers'
require 'words/text_source'
require 'words/document'
require 'words/corpus'
require 'words/generator'

require 'ruby-progressbar'

module Words
  include Frequencies::Sampling
  include Frequencies::Letters
  include Frequencies::Bigrams
  include TextHelpers

  def full_bigram_frequencies
    @full_bigram_frequencies ||= normalize_frequencies(full_bigram_counts)
  end

  def contains_vowels?(word)
    vowels.any? { |v| word.include?(v) }
  end
  
  def create_word_from_letter_bigrams
    result = ''
    len = (2..9).to_a.sample
    len = (5..20).to_a.sample if rand < 0.03
    until contains_vowels?(result)
      result = common_starting_letters.sample
      len.times do
	last_letter = result[result.length-1]
	freqs = full_bigram_frequencies.select { |k,_| k[0].downcase == last_letter }
	next_letter = Frequencies::Sampling.sample_frequencies(normalize_frequencies(freqs))[1]
	result = result + next_letter.downcase
      end
    end
    result
  end
  
  def random_word_frequencies(dict=nil)
    dict ||= dictionary
    generated_frequencies = dict.inject({}) do |hsh,elm|
      hsh[elm] = rand; hsh
    end
    @random_word_frequencies ||= normalize_frequencies(generated_frequencies)
  end

  DEFAULT_SOURCE_TEXTS = [ 
    # "./data/timaeus.txt",
    # "./data/king_in_yellow.txt",
    # "./data/melville-moby_dick.txt",
    # "./data/republic.mb.txt",
    # "./data/ulysses.txt",
    # "./data/theory_one.txt",
    "./data/freedom_of_love-breton.txt",
    # "./data/please_stop_worshipping_the_superstar.txt",
    "./data/lawrence-amores.txt"
  ]

  def sources
    @sources ||= Corpus.new(DEFAULT_SOURCE_TEXTS)
  end

  def word
    sources.word
  end

  def sentence
    sources.sentence
  end
end
