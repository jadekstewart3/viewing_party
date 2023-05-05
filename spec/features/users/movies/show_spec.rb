require "rails_helper"

RSpec.describe "Movie Details Page", :vcr do 
  describe "When I click on the title of a movie from the discover page" do 
    describe "I am taken to the movie details page" do 
      before :each do 
        @phil = User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "iloveclimbing", host: true)
        visit user_movie_path(@phil, 129)
      end
      it "displays a button to create a new viewing party" do 
        
      end
    end
  end
end