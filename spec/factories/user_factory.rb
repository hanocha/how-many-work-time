FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'test_password'
    code '1234567890'
  end
end