require 'spec_helper'
require 'words/frequencies/sampling'
require 'words/frequencies/ngram'
require 'words/text_source'
require 'words/document'
require 'words/generator'


require 'pry'

describe Words::Generator do


  subject do 
    Words::Generator.new(document)
  end

  let(:document) { Words::Document.new(text: text) }
  let(:text) do
    [%w[hello there you], %w[how are you], %w[nice day isnt it]]
  end

  context 'initial words' do
    describe "selecting a starting token" do
      let(:token) { subject.pick_initial }
      it 'should pick a token from the (weighted...) beginning of sentences' do
	token.should_not be_nil
	token.should be_a(String)
	%w[ hello how nice ].should include(token)
      end
    end
  end

  context "random token" do
    let(:token) { subject.pick("hello") }
    it 'should pick a random token' do
      token.should_not be_nil
      token.should be_a(String)
      document.content.flatten.should include(token)
    end
  end

  context 'probabilities' do
    it 'should calculate probabilities' do
      subject.pick(%w[hello]).should eql('there') 
    end
  end

  context 'walk' do
    let(:order) { 2 }
    it 'should perform a random walk' do
      walk = subject.walk(cycle: true)
      walk.should be_a(Array)
      walk.size.should be > 1
      walk.uniq.size.should be == walk.size
      walk.each { |w| document.content.flatten.should include(w) }
    end
  end
end
