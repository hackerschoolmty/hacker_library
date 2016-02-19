require 'rails_helper'

describe Book do 
  it "should be valid with name, author, description and slug" do
    book = build(:book)
    expect(book).to be_valid
  end

  it "should be invalid without name" do
    book = build(:book, name: nil)
    expect(book).to have(1).error_on(:name)
  end

  it "should be invalid without author" do
    book = build(:book, author: nil)
    expect(book).to have(1).error_on(:author)
  end

  it "should be invalid without description" do
    book = build(:book, description: nil)
    expect(book).to have(1).error_on(:description)
  end

  it "should be invalid without slug" do
    book = build(:book, slug: nil)
    expect(book).to have(1).error_on(:slug)
  end

  it "should be invalid with a duplicated slug" do
    create(:book, slug: "123456")
    book = build(:book, slug: "123456")
    expect(book).to_not be_valid
  end

  it "should clean slug field" do
    book = create(:book, slug: "123_4567")
    expect(book.slug).to eq("1234567")
  end


  it "should have many comments" do
    book = create(:book_with_comments) 
    expect(book.comments.count).to be >= 1
  end

  it "should have many pictures" do
    book = create(:book_with_pictures) 
    expect(book.pictures.count).to be >= 1
  end

  describe ".by_letter" do
    before(:each) do
      @rails_book = create(:rails_book)
      @ruby_book = create(:ruby_book)
      @spec_book = create(:spec_book)
    end

    context "With matching results" do
      it "returns a sorted array of books" do
        expect(Book.by_letter("R")).to eq [@rails_book, @ruby_book]
      end
    end

    context "With not-matching results" do
      it "should not return book that doesn't match " do
        expect(Book.by_letter("R")).to_not include  @spec_book
      end
    end
  end
end