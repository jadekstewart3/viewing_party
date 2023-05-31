require 'rails_helper'

RSpec.describe User, type: :model do
 describe "relationships" do 
  it { should have_many :party_users }
  it { should have_many(:parties).through(:party_users)}
 end

 describe "validations" do 
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :password_digest }
  it { should have_secure_password }
 end

 describe "#instance methods" do 
  describe "#host?" do 
    it "returns true if the user is the host of the party" do
      phil = User.create!(name: "Phil", email: "philipjfry33@gmail.com", password_digest: "password")
      amy = User.create!(name: "Amy", email: "amy_from_mars3@gmail.com", password_digest: "password")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(amy)
      party = Party.create!(date: "03/30/2024", start_time: "6:00", duration: 175, movie_id: 129)
      amy.party_users.create!(user_id: amy, party_id: party.id, host: amy )
      phil.party_users.create!(user_id: phil, party_id: party.id, host: false )

      expect(amy.host?(party)).to eq(true)
    end
  end

  describe "#my_parties" do 
    it "returns the parties that I am the host of" do 
      phil = User.create!(name: "Phil", email: "philipjfry33@gmail.com", password_digest: "password")
      amy = User.create!(name: "Amy", email: "amy_from_mars3@gmail.com", password_digest: "password")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(amy)

      party = Party.create!(date: "03/30/2024", start_time: "6:00", duration: 175, movie_id: 129)
      party_2 = Party.create!(date: "03/31/2024", start_time: "6:00", duration: 175, movie_id: 129)

      amy.party_users.create!(user_id: amy, party_id: party.id, host: amy )
      phil.party_users.create!(user_id: phil, party_id: party.id, host: false )

      amy.party_users.create!(user_id: amy, party_id: party_2.id, host: false )
      phil.party_users.create!(user_id: phil, party_id: party_2.id, host: amy )

      expect(amy.my_parties).to eq([party])
      expect(amy.my_parties).to_not eq([party_2])

      expect(phil.my_parties).to eq([party_2])
      expect(phil.my_parties).to_not eq([party])
    end
  end

  describe "#party_invites" do 
    it "returns the parties that I am invited to" do 
      phil = User.create!(name: "Phil", email: "philipjfry33@gmail.com", password_digest: "password")
      amy = User.create!(name: "Amy", email: "amy_from_mars3@gmail.com", password_digest: "password")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(amy)

      party = Party.create!(date: "03/30/2024", start_time: "6:00", duration: 175, movie_id: 129)
      party_2 = Party.create!(date: "03/31/2024", start_time: "6:00", duration: 175, movie_id: 129)

      amy.party_users.create!(user_id: amy, party_id: party.id, host: amy )
      phil.party_users.create!(user_id: phil, party_id: party.id, host: false )

      amy.party_users.create!(user_id: amy, party_id: party_2.id, host: false )
      phil.party_users.create!(user_id: phil, party_id: party_2.id, host: amy )

      expect(amy.party_invites).to eq([party_2])
      expect(amy.party_invites).to_not eq([party])

      expect(phil.party_invites).to eq([party])
      expect(phil.party_invites).to_not eq([party_2])
    end
  end
 end
end
