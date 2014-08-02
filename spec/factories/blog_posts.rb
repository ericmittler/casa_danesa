# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_post do
    title ""
    draft_body "Draft Body"
    published_body "Published Body"
    published_at "2014-02-18 16:05:28"
  end
end
