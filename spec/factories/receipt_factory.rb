FactoryBot.define do
  factory :receipt do
    title { FFaker::Name.unique.name }
  end
end