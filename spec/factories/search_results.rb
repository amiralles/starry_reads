FactoryBot.define do
  factory :search_result do
    isbn {Faker::Barcode.isbn()}
    source {["Google", "Amazon", "Open Library"].sample()}
    payload {Faker::String.random(length: (1..1024).to_a.sample())}
    processed {false}
  end
end
