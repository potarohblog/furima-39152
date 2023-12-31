FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials}
    email                 {Faker::Internet.free_email}
    password              {'test1234'}
    password_confirmation { password }
    last_name             {'漢字'}
    first_name            {'ひらがな'}
    last_name_kana        {'カタカナ'}
    first_name_kana       {'カタカナ'}
    birthday              {Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today)}
  end
end