require "rails_helper"

RSpec.describe "Dashboard" do 
  describe "As a User" do 
    describe "When I visit my dashboard" do
      before :each do 
        @amy = User.create!(name: "Amy", email: "amy_from_mars@gmail.com", password: "ilovemars", host: true) 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@amy)
        visit dashboard_path
      end

      it "displays the users name at the top of the page" do 
        within "#user" do
         expect(page).to have_content("#{@amy.name}'s Dashboard")
        end
      end

      it "displays a button to discover movies" do 
        expect(page).to have_button("Discover Movies")
      end

      it "displays a viewing parties section" do 
        expect(page).to have_content("Viewing Parties:")
      end
    end
  end
end