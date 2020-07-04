FactoryBot.define do
  factory :topic do
    description           { "Sample topic" }
    image_path            { "https://0c89f2017c8944ed96bfb5dad983c3b6.vfs.cloud9.us-east-2.amazonaws.com/uploads/topic/image_path/16/05.jpg" }
    password              { "hoge" }
    password_confirmation { "hoge" }
    association             :user
  end
  
  trait :without_password do
    password              { nil }
    password_confirmation { nil }
  end
  
end