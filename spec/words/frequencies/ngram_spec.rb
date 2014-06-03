require 'spec_helper'
require 'words/frequencies/sampling'
require 'words/frequencies/ngram'
require 'pry'

describe Words::Frequencies::Ngram do
  let(:document) do
    [%w[hello there you], %w[how are you], %w[nice day isnt it]]
  end

  before do
    subject.process_groups(document)
  end

  it 'should get values' do
    subject.gram_counts[%w[ hello ]].should eql(1)
    subject.gram_counts[%w[ there ]].should eql(1)
    subject.gram_counts[%w[ you ]].should eql(2)

    subject.gram_counts[%w[ hello there ]].should eql(1)
    subject.gram_counts[%w[ are you ]].should eql(1)

    # assumes order 3 at least
    subject.gram_counts[%w[ nice day isnt ]].should eql(1)
  end

  context "random token" do
    let(:token) { subject.pick }
    it 'should pick a random token' do
      token.should_not be_nil
      token.should be_a(String)
      document.flatten.should include(token)
    end
  end

  context "starting token" do
    let(:token) { subject.pick_initial }
    it 'should pick a token from the beginning of groups' do
      token.should_not be_nil
      token.should be_a(String)
      %w[ hello how nice ].should include(token)
    end
  end

  it 'should calculate probabilities' do
    subject.pick(%w[hello]).should eql('there') 
  end

  context 'walk' do
    it 'should perform a random walk' do
      walk = subject.walk
      walk.should_not be_nil
      walk.should be_a(Array)
      walk.should_not be_empty
      puts walk.join(' ')  + '. '
    end
  end

  context 'merge' do
    let(:other_document) { [%w[hello world], %w[i am a computer]] }
    let(:other_ngram) do
      ngram = Words::Frequencies::Ngram.new
      ngram.process_groups(other_document)
      ngram
    end

    it 'should merge counts and recalc probabilities' do
      subject.gram_counts[%w[ hello ]].should eql(1)
      subject.gram_counts[%w[ there ]].should eql(1)
      subject.gram_counts[%w[ you ]].should eql(2)

      subject.merge(other_ngram)

      subject.gram_counts[%w[ hello ]].should eql(2)
      subject.gram_counts[%w[ there ]].should eql(1)
      subject.gram_counts[%w[ computer ]].should eql(1)
    end
  end
end

