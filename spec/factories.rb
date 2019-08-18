FactoryBot.define do
  factory :event do
    category
    name { "Canada Day" }
    start_time { 5.days.from_now }
    end_time { 5.days.from_now + 4.hours }
  end

  factory :category do
    sequence :name do |n| "Pool Party #{n}" end
    sequence :slug do |n| "pool-party-#{n}" end
  end
end