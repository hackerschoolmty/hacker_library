require 'rails_helper'

describe BooksController do

  describe "GET 'index'" do

    before(:each) do
      get :index
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should retrive all books" do
      expect(assigns(:books)).to eq Book.all
    end

    it "should render :index template" do
      expect(response).to render_template :index
    end
  end

  describe "GET 'new'" do
    before(:each) do
      get :new
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should build a new book" do
      expect(assigns(:book)).to be_a_new Book
    end

    it "should render :new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @book = create(:book)
      get :edit, id: @book
    end

     it "should be success" do
      expect(response).to be_success
    end

    it "should find the requestted book" do
      expect(assigns(:book)).to eq(@book)
    end

    it "should render :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @book = create(:book)
      get :show, id: @book
    end

     it "should be success" do
      expect(response).to be_success
    end

    it "should find the requestted book" do
      expect(assigns(:book)).to eq(@book)
    end

    it "should render :edit template" do
      expect(response).to render_template :show
    end
  end

  describe "POST 'create'" do
    context "With valid attributes" do
      it "should save book into database" do
        expect{
          post :create, book: attributes_for(:book)
        }.to change(Book, :count).by(1)
      end

      it "should redirect to show detail" do
        post :create, book: attributes_for(:book)
        expect(response).to redirect_to book_path(assigns(:book))
      end
    end

    context "With invalid attributes" do
      it "should  not save book into database" do
        expect{
          post :create, book: attributes_for(:book, author: nil)
        }.to_not change(Book, :count)
      end

      it "should redirect to show detail" do
        post :create, book: attributes_for(:book, author: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @book = create(:book)
    end

    it "should find the request book" do
      put :update, id: @book, book: attributes_for(:book)
      expect(assigns(:book)).to eq(@book)
    end

    context "With valid attributes" do
      it "shoulld update book attributes" do
        put :update, id: @book, book: attributes_for(:book, name: "new name")
        @book.reload
        expect(@book.name).to eq("new name")
      end

      it "should redirect to book detail" do
        put :update, id: @book, book: attributes_for(:book, name: "new name")
        expect(response).to redirect_to book_path(@book)
      end
    end

    context "With invalid attributes" do
      it "should not update book attributes" do
        put :update, id: @book, book: attributes_for(:book, name: nil)
        expect(@book.name).to_not be_nil
      end

      it "should render :edit form" do
        put :update, id: @book, book: attributes_for(:book, name: nil)
        expect(response).to render_template :edit
      end
    end
  end


  describe "DELETE 'destroy'" do
    before(:each) do
      @book = create(:book)
    end

    it "should find requested book" do
      delete :destroy, id: @book
      expect(assigns(:book)).to eq @book
    end

    it "should destroy the book" do
      expect{
        delete :destroy, id: @book
      }.to change(Book, :count).by(-1)
    end

    it "should redirect to book path" do
      delete :destroy, id: @book
      expect(response).to redirect_to books_path
    end
  end
end