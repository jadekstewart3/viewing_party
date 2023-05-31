require "rails_helper"

RSpec.describe  "Welcome Page" do 
  describe "As a visitor" do
    describe "When I visit the welcome page" do

      let!(:phil) { User.create!(name: "Phil", email: "philipjfry@gmail.com", password: "pizzabeer") }
      let!(:amy) { User.create!(name: "Amy", email: "amy_from_mars@gmail.com", password: "ilovemars") }
      let!(:zoidberg) { User.create!(name: "Zoidberg", email: "dr_zoidberg_whoop_whoop_whoop_whoop@gmail.com", password: "whoopwhoop") }

      before :each do 
        visit root_path
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(phil)
      end

      it "displays the title of the application" do 
        expect(page).to have_content("Viewing Party")
      end

      it "displays a button to create a new user" do 
        expect(page).to have_button("Create New User")

        click_button "Create New User"

        expect(current_path).to eq(register_path)
      end

      it "displays the existing users names as links to their show page" do 
        expect(page).to have_link(phil.name.to_s)
        expect(page).to have_link(amy.name.to_s)
        expect(page).to have_link(zoidberg.name.to_s)
     
        click_link "Phil"

        expect(current_path).to eq(dashboard_path)

        visit root_path

        click_link "Amy"

        expect(current_path).to eq(dashboard_path)
      end

      it "displays a link to go back to the welcome page" do
        expect(page).to have_link("Home")
        click_link "Home"
        expect(current_path).to eq(root_path)
      end
    end
  end
end