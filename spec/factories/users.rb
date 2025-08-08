FactoryBot.define do
  factory :user do
    email { "user@test.com" }
    password { "password" }
    admin { false }
  end
end
