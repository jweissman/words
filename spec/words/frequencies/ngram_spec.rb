require 'spec_helper'
require 'words/frequencies/sampling'
require 'words/frequencies/ngram'
require 'words/text_source'
require 'words/document'
require 'words/generator'
require 'pry'

describe Words::Frequencies::Ngram do
  let(:text) do
    ['hello there you are', 
     'hi how are you today', 
     'nice day isnt it', 
     'yes nice day today',
     'well nice to meet up', 
     'yes nice to meet you']
  end
  let(:order) { 2 }

  subject do
    Words::Frequencies::Ngram.new(order)
  end

  before(:each) do
    subject.process_groups(text) 
  end

  context "order-1" do
    let(:order) { 1 }
    it 'should get values' do
      subject.gram_counts[%w[ hello ]].should eql(1)
      subject.gram_counts[%w[ there ]].should eql(1)
      subject.gram_counts[%w[ you ]].should eql(3)
    end
  end

  context "order-2" do
    let(:order) { 2 }
    it 'should get values' do
      subject.gram_counts[%w[ hello there ]].should eql(1)
      subject.gram_counts[%w[ are you ]].should eql(1)
      subject.gram_counts[%w[ you are ]].should eql(1)
    end
  end

  context "order-3" do
    let(:order) { 3 }
    it 'should get values' do
      subject.gram_counts[%w[ nice day isnt ]].should eql(1)
    end
  end

  context "picking options" do
    context 'order-2' do
      let(:order) { 2 }
      it 'should get options' do
        subject.get_options_and_probabilities(%w[hello]).should eql({'there' => 100.0})
        subject.get_options_and_probabilities(%w[are]).should eql({'you' => 100.0})
        subject.get_options_and_probabilities(%w[there]).should eql({'you' => 100.0})
        subject.get_options_and_probabilities(%w[you]).should eql({'today' => 50.0, 'are' => 50.0,})
      end
    end

    context 'order-3' do
      let(:order) { 3 }
      it 'should get options' do
        subject.get_options_and_probabilities(%w[hello there]).should eql({'you' => 100.0})
        subject.get_options_and_probabilities(%w[nice day]).should eql({'today' => 50.0, 'isnt' => 50.0})
      end
    end

    context 'order-4' do
      let(:order) { 4 }
      it 'should get options' do
        subject.get_options_and_probabilities(%w[how are you]).should eql({'today' => 100.0})
        subject.get_options_and_probabilities(%w[nice to meet]).should eql({'you' => 50.0, 'up' => 50.0})
      end
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
      subject.gram_counts[%w[ you ]].should eql(3)

      subject.merge(other_ngram)

      subject.gram_counts[%w[ hello ]].should eql(2)
      subject.gram_counts[%w[ there ]].should eql(1)
      subject.gram_counts[%w[ computer ]].should eql(1)
    end
  end
end

