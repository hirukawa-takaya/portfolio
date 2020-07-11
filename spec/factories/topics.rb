FactoryBot.define do
  factory :topic do
    description           { "Sample topic" }
    password              { "hoge" }
    password_confirmation { "hoge" }
    association :user

    trait :without_password do
      password              { nil }
      password_confirmation { nil }
    end
  end
end