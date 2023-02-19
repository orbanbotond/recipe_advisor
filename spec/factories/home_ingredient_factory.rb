FactoryBot.define do
  factory :home_ingredient do
    name { FFaker::Name.unique.name }
  end
end