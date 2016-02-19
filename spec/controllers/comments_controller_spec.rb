require 'rails_helper'

describe CommentsController do
  before(:each) do
    @book = create(:book)
  end

  describe "POST 'create'" do
    it "should create a comment" do 
      expect{
        post :create, book_id: @book, comment: attributes_for(:comment), format: :js
      }.to change(Comment, :count).by(1)
    end
  end
end