# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorization do
    provider "MyString"
    user_id 1
    uid "MyString"
    token "MyString"
  end
end
