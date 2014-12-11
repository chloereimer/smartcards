FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
  end

  factory :deck do
    user
    sequence(:name) { |n| "Deck #{n}" }
  end

  factory :card do
    deck
    sequence(:front) { |n| "Front #{n}" }
    sequence(:back) { |n| "Back #{n}" }
  end

end
