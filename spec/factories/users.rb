FactoryBot.define do
 factory :user do
   name                  { "hoge" }
   sequence(:email)      { |n| "hoge#{n}@hoge.com" }
   password              { "hogehoge" }
   password_confirmation { "hogehoge" }
 end
end