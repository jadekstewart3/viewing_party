require "rails_helper"

RSpec.describe "Dashboard" do 
  describe "As a User" do 
    describe "When I visit my dashboard" do

      before :each do 
        @amy = User.create!(name: "Amy", email: "amy_from_mars@gmail.com", password: "ilovemars") 
        @phil = User.create!(name: "Phil", email: "philip_j_fry@gmail.com", password: "ilovejade") 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@amy)
        @spirited_away = Party.create!(date: "05/28/2023", start_time: Time.now, duration: 2, movie_id: 1, movie_title: "Spirited Away", poster_path: "/iBy25orrkB1hjYNLCXdzMfXqWXR.jpg") 
        @ponyo = Party.create!(date: "05/30/2023", start_time: Time.now, duration: 2, movie_id: 1, movie_title: "Ponyo", poster_path: "/yp8vEZflGynlEylxEesbYasc06i.jpg") 
        
        PartyUser.create!(user_id: @phil.id, party_id: @spirited_away.id, host: false)
        PartyUser.create!(user_id: @amy.id, party_id: @spirited_away.id, host: true)
        PartyUser.create!(user_id: @phil.id, party_id: @ponyo.id, host: true)
        PartyUser.create!(user_id: @amy.id, party_id: @ponyo.id, host: false)

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

      it "displays a section of parties that I am hosting to" do 

        expect(page).to have_content("Parties I'm Hosting:")
        expect(page).to have_content("Movie: #{@spirited_away.movie_title}")
        expect(page).to have_content("Date: #{@spirited_away.date}")
        expect(page).to have_content("Start time: #{@spirited_away.start_time}")
        expect(page).to have_content("Duration: #{@spirited_away.duration}")
        expect(page).to have_content("Phil")
      end

      it "displays a section for parties that I am invited to" do         
        expect(page).to have_content("Parties I'm Attending:")
        expect(page).to have_content("Movie: #{@ponyo.movie_title}")
        expect(page).to have_content("Date: #{@ponyo.date}")
        expect(page).to have_content("Start time: #{@ponyo.start_time}")
        expect(page).to have_content("Duration: #{@ponyo.duration}")
        expect(page).to have_content("Phil")
      end
    end
  end
end