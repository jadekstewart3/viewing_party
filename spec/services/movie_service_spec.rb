require "rails_helper"

RSpec.describe MovieService do 
  describe "top_rated", :vcr do 
    it "returns top rated movies" do
      top_rated_movies = MovieService.new.top_rated

      expect(top_rated_movies).to be_a(Hash)

      expect(top_rated_movies).to have_key(:results)
      expect(top_rated_movies[:results]).to be_an(Array)

      top_rated_movies[:results].each do |movie|
        expect(movie).to have_key(:title)
        expect(movie[:title]).to be_a(String)

        expect(movie).to have_key(:vote_average)
        expect(movie[:vote_average]).to be_a(Float)
      end
    end
  end

  describe "movie_search", :vcr do 
    it "returns searched movies" do 
      searched = MovieService.new.movie_search("Spirited")
     
      expect(searched).to be_a(Hash)

      expect(searched).to have_key(:results)
      expect(searched[:results]).to be_an(Array)

      searched[:results].each do |movie|
        expect(movie).to have_key(:title)
        expect(movie[:title]).to be_a(String)

        expect(movie).to have_key(:vote_average)
        expect(movie[:vote_average]).to be_a(Float)
      end
    end
  end

  describe "get_movie_details", :vcr do 
    it "returns a specific movies details" do
      deets = MovieService.new.get_movie_details(129)
      expect(deets).to be_a(Hash)

      expect(deets).to have_key(:title)
      expect(deets[:title]).to be_a(String)

      expect(deets).to have_key(:vote_average)
      expect(deets[:vote_average]).to be_a(Float)

      expect(deets).to have_key(:runtime)
      expect(deets[:runtime]).to be_an(Integer)

      expect(deets).to have_key(:genres)
      expect(deets[:genres]).to be_an(Array)

      expect(deets).to have_key(:overview)
      expect(deets[:overview]).to be_a(String)
    end
  end

  describe "get_cast", :vcr do 
    it "returns a cast list for a movie" do
      cast = MovieService.new.get_cast(129)
      expect(cast).to be_a(Hash)

      expect(cast).to have_key(:cast)
      expect(cast[:cast]).to be_an(Array)

      cast[:cast].each do |member|
        expect(member).to have_key(:name)
        expect(member[:name]).to be_a(String)

        expect(member).to have_key(:character)
        expect(member[:character]).to be_a(String)
      end
    end
  end

  describe "get_reviews", :vcr do 
    it "returns the reviews for a movie" do 
      reviews = MovieService.new.get_reviews(129)

      expect(reviews).to be_a(Hash)

      expect(reviews).to have_key(:results)
      expect(reviews[:results]).to be_an(Array)

      reviews[:results].each do |review|
        expect(review).to have_key(:author)
        expect(review[:author]).to be_a(String)

        expect(review).to have_key(:content)
        expect(review[:content]).to be_a(String)
      end
    end
  end
end