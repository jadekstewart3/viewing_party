require "rails_helper"
RSpec.describe "Viewing Party New Page" do
  
  describe "When I visit the movie details page", :vcr do
    before :each do
      @phil = User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "ilovejade") 
      @amy = User.create!(name: "Amy", email: "amy_from_mars@gmail.com", password: "marsrocks")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@phil)
      visit user_discover_index_path(@phil)
      click_button "Discover Top Rated Movies"
      click_link "The Godfather"
      click_button "Create Viewing Party"
    end
    it "displays the title of the movie at the top of the page" do
      expect(page).to have_content("Movie: The Godfather")
    end

    it "displays a form to create a viewing party with the duration prefilled in minutes" do
      expect(page).to have_field(:duration)
      expect(page).to have_field(:date)
      expect(page).to have_field(:start_time)
      expect(page).to have_content("Amy")
      expect(page).to_not have_content("Philip")
    end

    it "when I fill in the form and click on create party, I am redirected to my dashboard" do
      fill_in :date, with: Date.tomorrow
      fill_in :start_time, with: Time.now.strftime("%I:%M")
      check @amy.name
      click_button "Create Party"

      expect(current_path).to eq(dashboard_path)
    end
  end
end