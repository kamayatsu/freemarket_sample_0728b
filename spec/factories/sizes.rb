FactoryBot.define do
  factory :size do
    id    {"1"}
    size  {"XXS以下"}

    association :size_type
  end
end