require "rails_helper"

RSpec.describe "Logging In do"
describe "As a visitor" do
  describe "When I visit the login page" do 
    it "can login with valid credentials" do 
      user = User.create!(name: "Jenna", email: "j_dawg@gmail.com", password: "jaymonayyyy")

      visit  root_path
        save_and_open_page
      click_button "Log In"
    
      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, Jenna!")
    end
  end
end