require 'spec_helper'
require 'words/frequencies/sampling'
require 'words/frequencies/ngram'
require 'words/text_source'
require 'words/document'
require 'words/generator'
require 'pry'

describe Words::Frequencies::Ngram do
  let(:text) do
    [%w[hello there you], %w[how are you], %w[nice day isnt it]]
  end

  subject do
    Words::Frequencies::Ngram.new(order)
  end

  before do
    subject.process_groups(text)
    subject.postprocess
  end

  context "order-1" do
    let(:order) { 1 }
    it 'should get values' do
      subject.gram_counts[%w[ hello ]].should eql(1)
      subject.gram_counts[%w[ there ]].should eql(1)
      subject.gram_counts[%w[ you ]].should eql(2)
    end
  end

  context "order-2" do
    let(:order) { 2 }
    it 'should get values' do
      subject.gram_counts[%w[ hello there ]].should eql(1)
      subject.gram_counts[%w[ are you ]].should eql(1)
    end
  end

  context "order-3" do
    let(:order) { 3 }
    it 'should get values' do
      subject.gram_counts[%w[ nice day isnt ]].should eql(1)
    end
  end

  # context "random token" do
  #   let(:token) { subject.pick }
  #   it 'should pick a random token' do
  #     token.should_not be_nil
  #     token.should be_a(String)
  #     document.flatten.should include(token)
  #   end
  # end

  context "starting token" do
    # before { subject.normalize! }
    let(:token) { subject.pick_initial }
    let(:order) { 1 }
    it 'should pick a token from the beginning of groups' do
      token.should_not be_nil
      token.should be_a(String)
      %w[ hello how nice ].should include(token)
    end
  end

  context "picking options" do
    let(:order) { 2 }
    it 'should get options' do
      subject.get_options_and_probabilities(%w[hello]).should eql({'there' => 100.0})
    end

    # TODO move to own specs...?
    it 'should calculate probabilities' do
      Generator.new(Document.new(text: text)).pick(%w[hello]).should eql('there') 
    end
  end

  context 'walk' do
    let(:order) { 2 }
    it 'should perform a random walk' do
      walk = Words::Generator.new(Document.new(text: text)).walk(cycle: false)
      walk.should_not be_nil
      walk.should be_a(Array)
      walk.should_not be_empty
      walk.size.should be > 1
      walk.uniq.size.should be == walk.size

      puts walk.join(' ')  + '. '
    end
  end

  context 'merge' do
    let(:order) { 1 }
    let(:other_document) { [%w[hello world], %w[i am a computer]] }
    let(:other_ngram) do
      ngram = Words::Frequencies::Ngram.new(1)
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

