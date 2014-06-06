module Words
  module TextSource
    include TextHelpers
    def generator(target=self)
      @generator = Generator.new(target) unless @generator && @generator.source == target
      @generator
    end

    def word;     generator.word.first end
    def sentence; generator.sentence end
  end
end
