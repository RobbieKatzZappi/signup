FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name  { 'Doe' }
    email  { 'test@gmail.com' }
    password_digest { 'foobarbaz' }
  end
end
