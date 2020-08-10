FactoryBot.define do
  factory :topic do
    description         { "Sample topic" }
    password            { "hoge" }
    association :user

    trait :without_password do
      password          { nil }
    end
    
    trait :other_topic do
      description       { "hogehoge" }
    end
  end
end