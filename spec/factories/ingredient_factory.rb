FactoryBot.define do
  factory :ingredient do
    name { FFaker::Name.unique.name }
    receipt
  end
end