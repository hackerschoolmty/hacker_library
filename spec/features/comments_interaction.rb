require 'rails_helper'

feature "comments interaction" do
  before(:each) do
    @user = create(:user)
    feature_sign_in @user
  end
  scenario "Creating comments" do
    book = create(:book)
    visit book_path(id: book)
    expect{
      fill_in "comment_description", with: Faker::Lorem.sentence(20)
      click_button "Agregar"
    }.to change(Comment, :count).by(1)
  end

  scenario "Visualizing comments" do
    book = create(:book)
    visit book_path(id: book)
    comment = Faker::Lorem.sentence(20)
    fill_in "comment_description", with: comment
    click_button "Agregar"
    expect(page).to have_content comment
    sleep(2)
  end

  scenario "Deleting comments" do
    book = create(:book)
    comment = create(:comment, book: book, user: @user)
    visit book_path(id: book)
    
    within "#comment_#{comment.id}" do
      click_link "Eliminar"
    end
    page.accept_alert
    sleep(1)
    expect(page).to_not have_selector "#comment_#{comment.id}"
  end
end