require 'rails_helper'

describe CommentsController do
   before(:each) do
    @book = create(:book)
  end

  shared_examples "can create comments" do
    describe "POST 'create'" do
     
      it "should create a comment" do 
        expect{
          post :create, book_id: @book, comment: attributes_for(:comment), format: :js
        }.to change(Comment, :count).by(1)
      end

      it "should respond with js" do
        post :create, book_id: @book, comment: attributes_for(:comment), format: :js
        expect(response.headers["Content-Type"]).to eq("text/javascript; charset=utf-8")
      end
    end
  end

  describe "admin access" do
    before(:each) do
      sign_in_as_admin
    end
    
    it_behaves_like "can create comments"

    describe "DELEtE 'destroy' " do
      before(:each) do
        @comment = create(:comment, book: @book)
      end

      it "should delete the comment" do
        expect{
          delete :destroy, book_id: @book, id: @comment, format: :js
        }.to change(Comment, :count).by(-1)
      end
    end
  end

  describe "regular access" do
    before(:each) do
      sign_in_as_regular
    end

    it_behaves_like "can create comments"

    describe "DELETE 'destroy'" do
      context "With related comments" do
        before(:each) do
          @comment = create(:comment, book: @book, user: @user)
        end

        it "should delete the comment" do
          expect{
            delete :destroy, book_id: @book, id: @comment, format: :js
          }.to change(Comment, :count).by(-1)
        end
      end

      context "With non related comments" do
        before(:each) do
          another_user = create(:user, email: "another@hackerschool.com")
          @comment = create(:comment, book: @book, user: another_user)
        end

        it "should not delete the comment" do
          expect{
            delete :destroy, book_id: @book, id: @comment, format: :js
        
          }.to raise_error CanCan::AccessDenied 
        end
      end
    end
    
  end

  describe "guest access" do
    describe "POST 'create'" do
      it "should not be success" do
        post :create, book_id: @book, comment: attributes_for(:comment), format: :js
        expect(response).to_not be_success
      end
    end
  end
end