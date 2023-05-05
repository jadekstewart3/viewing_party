require "rails_helper"

RSpec.describe "Movie Details Page", :vcr do 
  describe "When I click on the title of a movie from the discover page" do 
    describe "I am taken to the movie details page" do 
      before :each do 
        @phil = User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "iloveclimbing", host: true)
        visit user_movie_path(@phil, 129)
      end
      it "displays the movie's attributes" do 
        expect(page).to have_content("Spirited Away")
        expect(page).to have_content("Summary:")
        expect(page).to have_content("Runtime:")
        expect(page).to have_content("Vote Average:")
        expect(page).to have_content("Genres:")
        expect(page).to have_content("Cast:")
        expect(page).to have_content("Reviews:")
        expect(page).to have_content("Total Reviews:")
      end
    end
  end
end