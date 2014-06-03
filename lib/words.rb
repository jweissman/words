require 'words/version'

require 'words/frequencies/sampling'
require 'words/frequencies/letters'
require 'words/frequencies/bigrams'
require 'words/frequencies/ngram'
require 'words/document'
require 'words/corpus'

module Words
  include Frequencies::Sampling
  include Frequencies::Letters
  include Frequencies::Bigrams

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
    # "./data/theory_one.txt"
    "./data/freedom_of_love-breton.txt"
  ]
  def source_corpus(texts=DEFAULT_SOURCE_TEXTS)
    @current_texts ||= nil
    @source_texts  ||= []
    unless @current_texts == texts
      @source_texts = texts.map { |text| Document.new(text) }
      @source_corpus = Corpus.new(@source_texts)
      @current_texts  = texts
    end

    @source_corpus
  end

  def word
    source_corpus.word
  end

  def sentence
    source_corpus.sentence
  end

  def title
    sentence.gsub('.', '')
  end

  def paragraph
    sentences = Array.new((3..7).to_a.sample) { sentence }
    sentences.join + "\n\n"
  end

  def with_title(t,content,depth=0)
    [t,"\n\n",content].join
  end

  def document(t=title)
    graphs = Array.new((5..35).to_a.sample) { paragraph }
    with_title(t,graphs)
  end

  def corpus(t=title)
    docs = Array.new((8..20).to_a.sample) { document }
    with_title(t,docs)
  end

  def oeuvre(t=title)
    corpora = Array.new((4..10).to_a.sample) { corpus }
    with_title(t,corpora)
  end
end
