FactoryBot.define do
  factory :user, aliases: [:owner] do
    name                  { "hoge" }
    sequence(:email)      { |n| "hoge#{n}@hoge.com" }
    password              { "hogehoge" }
    password_confirmation { "hogehoge" }
  end
end