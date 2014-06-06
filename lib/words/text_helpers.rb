module Words
  module TextHelpers
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

    def dice_throw
      (2..3).to_a.sample
    end

    def document(t=title)
      count = dice_throw
      progress = ProgressBar.create(:title => "Generate (Document)", :total => count, :finish => lambda{ |it,i,result| progress.increment})
      graphs = Parallel.map(Array.new(count), :in_threads => 4) { paragraph }
      with_title(t,graphs)
    end

    def corpus(t=title)
      count = dice_throw
      progress = ProgressBar.create(:title => "Generate (Corpus)", :total => count)
      docs = Parallel.map(Array.new(count), :in_threads => 4, :finish => lambda{ |it,i,result| progress.increment}) { document }
      with_title(t,docs)
    end

    def oeuvre(t=title)
      count = dice_throw
      progress = ProgressBar.create(:title => "Generate (Oeuvre)", :total => count)
      corpora = Parallel.map(Array.new(count), :in_threads => 4, :finish => lambda{ |it,i,result| progress.increment}) { corpus }
      with_title(t,corpora)
    end
  end
end
