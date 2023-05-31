require "rails_helper"

RSpec.describe MovieFacade do 
  describe "#instance methods" do 
    describe "get_top_rated_movies", :vcr do 
      it "returns a list of 20 top rated movies" do 

        top_movies = MovieFacade.new.get_top_rated_movies
      
        top_movies.each do |movie|
          expect(movie).to be_a(Movie)
          expect(movie.movie_id).to be_an(Integer)
          expect(movie.title).to be_a(String)
          expect(movie.vote_average).to be_a(Float)
          expect(movie.runtime).to be(nil)
          expect(movie.genres).to be(nil)
          expect(movie.summary).to be(nil)
          expect(movie.cast).to be(nil)
          expect(movie.total_reviews).to be(nil)
          expect(movie.review_info).to be(nil)
        end
      end
    end

    describe "get_searched_movies", :vcr do 
      it "returns a list of searched movies" do
        searched_movies = MovieFacade.new.get_searched_movies(title: "ponyo")

        searched_movies.each do |movie|
          expect(movie).to  be_a(Movie)
          expect(movie.title).to be_a(String)
          expect(movie.vote_average).to be_a(Float)
          expect(movie.runtime).to be(nil)
          expect(movie.genres).to be(nil)
          expect(movie.summary).to be(nil)
          expect(movie.cast).to be(nil)
          expect(movie.total_reviews).to be(nil)
          expect(movie.review_info).to be(nil)
        end
      end
    end

    describe "get_movie_details", :vcr do 
      it "returns a movies full details" do 
        movie = MovieFacade.new.get_movie_details(129)

        expect(movie.title).to be_a(String)
        expect(movie.vote_average).to be_a(Float)
        expect(movie.runtime).to be_an(String)
        expect(movie.genres).to be_an(Array)
        expect(movie.summary).to be_a(String)
        expect(movie.cast).to be_an(Array)
        expect(movie.total_reviews).to be_an(Integer)
        expect(movie.review_info).to be_an(Array)
        expect(movie.poster_path).to be_a(String)
      end
    end
  end
end