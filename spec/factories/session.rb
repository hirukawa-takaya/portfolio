FactoryBot.define do
  factory :session do
    email                 { |n| "hoge#{n}@hoge.com" }
    password              { "hogehoge" }
  end
end