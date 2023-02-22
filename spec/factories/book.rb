FactoryBot.define do
  factory :book, class: Book do
    name { "Example" }
    course { "Bsc" }
    ref { "2045012" }
    phone { "02312322" }
    on_at { Time.local(2022, 4, 4, 10) }
  end
end
