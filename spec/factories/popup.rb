FactoryBot.define do
  factory :popup, class: Popup do
    on_at { Time.local(2022, 4, 5, 10) }
  end
end
