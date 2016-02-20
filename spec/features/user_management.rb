require 'rails_helper'

feature "user management" do
  scenario "Create a new user" do
    visit root_path
    expect{
      click_link "Sign up"
      fill_in "Name", with: Faker::Name.name
      fill_in "Email", with: "user@hackerschool.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Sign up"

    }.to change(User, :count).by(1)
    save_and_open_screenshot
  end
end