require "rails_helper"

RSpec.describe Movie do 
  describe "instance methods" do 
    describe "#initalize", :vcr do 
      before :each do 
        @spirited_away = MovieFacade.new(movie_id: 1001196).get_movie_details
      end
      it "exists" do 
        expect(@spirited_away).to be_a(Movie)
      end

      it "has attributes" do 
        expect(@spirited_away.title).to eq("Spirited Away: Live on Stage")
        expect(@spirited_away.vote_average).to eq(8.2)
        expect(@spirited_away.runtime).to eq("2 hours 55 minutes")
        expect(@spirited_away.genres).to eq(["Drama", "Adventure", "Family", "Fantasy"])
        expect(@spirited_away.summary).to eq("A young girl named Chihiro finds herself trapped in a mysterious world inhabited by spirits and when her parents are turned into pigs, she must rescue them. The movie version of the stage production was filmed during the play’s 2022 run at the Imperial Theatre in Tokyo." )
        expect(@spirited_away.cast).to be_an(Array)
        expect(@spirited_away.total_reviews).to eq(0)
        expect(@spirited_away.review_info).to be_an(Array)
      end
    end
  end
end