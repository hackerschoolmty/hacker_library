FactoryGirl.define do
  factory :user, class: User do
    name { Faker::Name.name }
    role "admin"
    email "admin@hackerschool.com"
    password "password"
    password_confirmation "password"

    factory :regular_user do
      role "regular"
    end
  end
end