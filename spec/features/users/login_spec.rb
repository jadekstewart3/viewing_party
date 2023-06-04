require "rails_helper"

RSpec.describe "Logging In do"
describe "As a visitor" do
  describe "When I visit the login page" do 
    before :each do
      @user = User.create!(name: "Jenna", email: "j_dawg@gmail.com", password: "jaymonayyyy")
      visit  login_path
    end
    it "can login with valid credentials" do 

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_button "Login"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Jenna's Dashboard")
    end

    it "will not allow login with invalid credentials" do 
      fill_in :email, with: "g_dawg@gmail.com"
      fill_in :password, with: "gmonayyyy"

      click_button "Login"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry your credentials are bad.")
    end
  end
end