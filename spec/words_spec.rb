require 'spec_helper'
require 'words'
require 'pry'

include Words
describe Words do

   it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
# end

# TODO bring these back...? figure out why they're breaking...!
# 
  it "should generate a word" do
    w = subject.word
    w.should_not be_nil
    w.should_not be 'a'
    # puts w
  end

  it 'should generate a sentence' do
    s = subject.sentence
    s.should_not be_nil
    s.should be_a String
    # puts s
  end

  it 'should generate a paragraph' do
    graph = subject.paragraph
    graph.should_not be_nil
    graph.should be_a String
    # puts graph
  end

  it 'should generate a document' do
    doc = subject.document
    doc.should_not be_nil
    doc.should be_a String
    # puts doc
  end

  it 'should generate a corpus' do
    c = subject.corpus
    c.should_not be_nil
    c.should be_a String
    # puts c
  end

  it 'should generate an oeuvre' do
    o = subject.oeuvre
    o.should_not be_nil
    o.should be_a String
    # puts o
  end
end

