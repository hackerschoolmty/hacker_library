FactoryGirl.define do
  factory :picture do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'grumpy.jpg')) }
  end
end