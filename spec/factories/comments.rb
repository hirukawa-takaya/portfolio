FactoryBot.define do
  factory :comment do
    content  { "test" }
    association :topic
    association :user
  end
end
