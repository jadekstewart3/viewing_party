require "rails_helper"

RSpec.describe "Discover Movies" do 
  describe "As a visitor" do 
    describe "When I click the discover movies button" do

      let!(:zoidberg) { User.create!(name: "Zoidberg", email: "doc_z_berg@gmail.com", password: "drz_") }

      before :each do
        visit user_discover_index_path(zoidberg)
      end

      it "displays a button to discover top rated movies" do 
        expect(page).to have_button("Discover Top Rated Movies")

        click_button "Discover Top Rated Movies"

        expect(current_path).to eq(user_movies_path(zoidberg))
        expect(page).to have_content("Title", count: 20)
      end

      it "displays a form to enter keywords to search by movie title" do
        expect(page).to have_field(:title)
        expect(page).to have_button("Find Movies")

        fill_in :title, with: "Spirited"

        click_button "Find Movies"

        expect(current_path).to eq(user_movies_path(zoidberg))
        expect(page).to have_content("Title", count: 20)
      end
    end
  end
end