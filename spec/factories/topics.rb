FactoryBot.define do
  factory :topic do
    description           { "Sample topic" }
    # image_path
    password              { "hoge" }
    password_confirmation { "hoge" }
    association           :user
  end
end
