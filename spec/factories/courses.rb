FactoryBot.define do
  factory :course do
    title { Faker::Name.name }

    author
  end
end
