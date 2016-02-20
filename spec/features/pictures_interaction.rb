require 'rails_helper'

feature "pictures interaction" do
  before(:each) do
    @user = create(:user)
    @book = create(:book)
    feature_sign_in @user
   
  end

  scenario "Adding a picture" do
     visit book_path(id: @book)
    expect{
      page.attach_file("picture[image]", "#{Rails.root}/spec/support/images/grumpy.jpg")
      click_button "Guardar"
      sleep(1)
    }.to change(Picture, :count).by(1)
   expect(page).to have_selector "#picture_#{Picture.last.id}"
  end

  scenario "Removing a picture" do
    picture = create(:picture, picturable: @book)
    visit book_path(id: @book)
    within "#picture_#{picture.id}" do
      click_link "Eliminar"
    end
    sleep(5)
    expect(page).to_not have_selector "#picture_#{picture.id}"
  end
end