FactoryGirl.define do
  factory :notifier do
    user
    slack_user_name 'test'
  end
end