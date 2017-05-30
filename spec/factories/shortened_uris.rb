FactoryGirl.define do
  factory :shortened_uri do
    original_uri { Faker::Internet.url }
    shortened_relative_uri nil
  end
end
