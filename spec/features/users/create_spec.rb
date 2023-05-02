require "rails_helper"

RSpec.describe "Registration Page" do 
  describe "As a visitor" do 
    describe "When I visit the registration page" do 
      describe "When successful" do
        
        it "fills in the form to create a new user" do 
          name = "Hypno-Toad"
          email = "hypno_todude@gmail.com"
          password = "password"
          visit register_path
       
          fill_in :user_name, with: name
          fill_in :user_email, with: email
          fill_in :user_password, with: password
          fill_in :user_password_confirmation, with: password

          click_button "Register"

          new_user = User.last

          expect(current_path).to eq(dashboard_path)
          # add content expectations to this test
        end
      end

      describe "When Unsuccessful" do 
        it "will not create a user without password confirmation" do 
          name = "Hypno-Toad"
          email = "hypno_todude@gmail.com"
          password = "password"

          visit register_path
          
          fill_in :user_name, with: name
          fill_in :user_email, with: email
          fill_in :user_password, with: password
          fill_in :user_password_confirmation, with: ""
          
          click_button "Register"
         
          expect(page).to have_content("Password confirmation doesn't match Password")
        end

        it "displays appropriate error messages when invalid information is entered" do
          visit register_path

          fill_in :user_name, with: ""
          fill_in :user_email, with: ""
          fill_in :user_password, with: ""
          fill_in :user_password_confirmation, with: ""

          click_button "Register"
        
          expect(current_path).to eq(register_path)
          expect(page).to have_content("Name can't be blank")
          expect(page).to have_content("Email can't be blank")
          expect(page).to have_content("Password digest can't be blank")
          expect(page).to have_content("Password can't be blank")

          expect(current_path).to eq(register_path)
        end
      end
    end
  end
end