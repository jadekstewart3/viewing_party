require "rails_helper"

RSpec.describe "Dashboard" do 
  describe "As a User" do 
    describe "When I visit my dashboard" do

      before :each do 
        @amy = User.create!(name: "Amy", email: "amy_from_mars@gmail.com", password: "ilovemars", host: true) 
        @phil = User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "ilovejade", host: false) 
        @spirited_away = Party.create!(date: "05/28/2023", start_time: Time.now, duration: 2, movie_id: 1) 

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@amy)
        PartyUser.create!(user_id: @phil.id, party_id: @spirited_away.id)
        PartyUser.create!(user_id: @amy.id, party_id: @spirited_away.id)

        visit dashboard_path
      end

      it "displays the users name at the top of the page" do 
        within "#user" do
         expect(page).to have_content("#{@amy.name}'s Dashboard")
         expect(page).to_not have_content("#{@phil.name}'s Dashboard")
        end
      end

      it "displays a button to discover movies" do 
        expect(page).to have_button("Discover Movies")

        click_button "Discover Movies"

        expect(current_path).to eq(user_discover_index_path(@amy.id))
      end

      it "displays a viewing parties section" do 
        expect(page).to have_content("Viewing Parties:")

        expect(page).to have_content("Movie id: #{@spirited_away.movie_id}")
        expect(page).to have_content("Date: #{@spirited_away.date}")
        expect(page).to have_content("Start time: #{@spirited_away.start_time.strftime('%I:%M')}")
        expect(page).to have_content("Duration: #{@spirited_away.duration}")
      end
    end
  end
end