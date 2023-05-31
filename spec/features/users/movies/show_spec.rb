require "rails_helper"

RSpec.describe "Movie Details Page", :vcr do 
  describe "When I click on the title of a movie from the discover page" do 
    describe "I am taken to the movie details page" do 
      before :each do 
        @phil = User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "iloveclimbing")
        visit user_movie_path(@phil, 129)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@phil)
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

      it "displays a button to return to the discover page" do 
        expect(page).to have_button("Discover Page")

        click_on "Discover Page"

        expect(current_path).to eq(user_discover_index_path(@phil))
      end

      it "displays a button to create a viewing party" do 
        expect(page).to have_button("Create Viewing Party")

        click_button "Create Viewing Party"
      
        expect(current_path).to eq(new_user_movie_party_path(@phil, 129))
      end
    end
  end
end