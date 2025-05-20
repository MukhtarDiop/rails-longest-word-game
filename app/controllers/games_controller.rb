class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

 def score
    @word = params[:word].upcase
    @grid = params[:grid].is_a?(String) ? params[:grid].split(",") : Array(params[:grid])

    if !word_in_grid?(@word, @grid)
      @message = "❌ The word can't be built out of the original grid"
    elsif !english_word?(@word)
      @message = "❌ The word is not a valid English word"
    else
      @message = "✅ Well done!"
    end
 end

  private

 def word_in_grid?(word, grid)
  word.chars.tally.all? { |letter, count| grid.count(letter) >= count }
 end


  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json['found']
  end
end
