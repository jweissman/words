require 'spec_helper'
require 'words/frequencies/sampling'
require 'words/frequencies/ngram'
require 'words/text_helpers'
require 'words/text_source'
require 'words/document'
require 'words/generator'
require 'pry'

describe Words::Document do
  subject do
    Document.new(file: './data/please_stop_worshipping_the_superstar.txt') # reedom_of_love-breton.txt')
  end

  let(:word)     { subject.word }
  let(:sentence) { subject.sentence }

  it 'should generate likely sentences' do 
    %w[ word sentence document corpus oeuvre ].each do |w|
      work = subject.send(w)
      work.should_not be_nil
      work.should be_a String
      # puts work
      work.split.size.should be > 1 unless w == 'word'
    end
  end
end
