  class SignUp < ActiveType::Record[User]
    attribute :password
    attribute :password_confirmation

    validate :password_confirmation_correctness
    validates_length_of :password, minimum: 8, allow_nil: true
    validate :email_correctness

    validates :date_of_birth, inclusion: { in: 150.years.ago..18.years.ago }, allow_nil: true
    validates :gender, inclusion: { in: ['male', 'female', 'non-binary'] }, allow_nil: true

    before_save :create_password_digest

    private

    def create_password_digest
      return unless password.present?

      self.password_digest = Digest::SHA1.hexdigest(password)
    end

    def email_correctness
      if (email =~ /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$/).nil?
        errors.add(:email, 'email is not correct')
      end
    end

    def password_confirmation_correctness
      if password != password_confirmation
        errors.add(:base, 'password confirmation failure')
      end
    end
  end
