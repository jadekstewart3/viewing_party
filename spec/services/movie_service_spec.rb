require "rails_helper"

RSpec.describe MovieService do 
  describe "top_rated", :vcr do 
    it "returns top rated movies" do
      top_rated_movies = MovieService.new.top_rated
      
      expect(top_rated_movies).to be_a(Hash)

      expect(top_rated_movies).to have_key(:results)
      expect(top_rated_movies[:results]).to be_an(Array)

      top_rated_movies[:results].each do |movie|
        expect(movie).to have_key(:original_title)
        expect(movie[:original_title]).to be_a(String)

        expect(movie).to have_key(:vote_average)
        expect(movie[:vote_average]).to be_a(Float)
      end
    end
  end
end