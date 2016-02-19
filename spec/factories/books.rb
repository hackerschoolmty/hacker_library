FactoryGirl.define do
  factory :book do
    name { Faker::Book.title }
    author { Faker::Name.name }
    description { Faker::Lorem.sentence(3) }
    sequence(:slug) {|n| "123123_#{n}"} 

    factory :rails_book do
      name "Rails book"
    end

    factory :ruby_book do
      name "Ruby book"
    end

    factory :spec_book do
      name "Spec book"
    end

    factory :book_with_comments do
      after(:create) do |book|
        create_list(:comment, rand(2..10), book: book)
      end
    end

    factory :book_with_pictures do
      after(:create) do |book|
        create_list(:picture, rand(2..10), picturable: book)
      end
    end
  end
end