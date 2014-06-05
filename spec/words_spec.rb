require 'spec_helper'
require 'words'
require 'pry'

describe Words do
  # before do
  #   subject.source_corpus ['./data/hello.txt']
  # end

  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end

  it "should generate a word" do
    word = subject.word
    word.should_not be_nil
    word.should_not be 'a'
    puts word
  end

  it 'should generate a sentence' do
    3.times {
      sentence = subject.sentence
      sentence.should_not be_nil
      sentence.should be_a String
      puts sentence
    }
  end
  
  it 'should generate a paragraph' do
    paragraph = subject.paragraph
    paragraph.should_not be_nil
    paragraph.should be_a String
    puts paragraph
  end

  it 'should generate a document' do
    document = subject.document
    document.should_not be_nil
    document.should be_a String
    puts document
  end

  it 'should generate a corpus' do
    corpus = subject.corpus
    corpus.should_not be_nil
    corpus.should be_a String
    puts corpus
  end

  it 'should generate an oeuvre' do
    oeuvre = subject.oeuvre
    oeuvre.should_not be_nil
    oeuvre.should be_a String
    puts oeuvre
  end
end

describe Words::Document do
  subject do
    Document.new(file: './data/freedom_of_love-breton.txt')
  end

  let(:word)     { subject.word }
  let(:sentence) { subject.sentence }

  it 'should take a source text and generate words' do
    word.should_not be_nil
    word.should be_a String
    puts word
  end

  it 'should take a document and generate likely sentences' do
    sentence.should_not be_nil
    sentence.should be_a String
    puts sentence
  end
end
