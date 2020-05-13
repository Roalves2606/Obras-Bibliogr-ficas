require 'faker'

FactoryBot.define do
  max_records = 3

  factory :author_list do
    records { max_records }

    original_list do
      array = []

      max_records.times do
        array.push(Faker::Name.name)
      end

      array
    end
  end
end
