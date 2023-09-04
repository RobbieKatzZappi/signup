class User < ApplicationRecord
  validates :date_of_birth, inclusion: { in: 150.years.ago..18.years.ago }, allow_nil: true
  validates :gender, inclusion: { in: ['male', 'female', 'non-binary'] }, allow_nil: true
end
