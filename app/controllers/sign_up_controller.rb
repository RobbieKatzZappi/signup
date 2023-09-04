class SignUpController < Base
  def show
    render :create
  end

  def create
    sign_up = SignUp.new(create_params)
    sign_up.save
    if sign_up.errors.present?
      render :error
    else
      set_current_user(ActiveType.cast(sign_up, User))
      render :update
    end
  end

  def update
    sign_up = ActiveType.cast(current_user, SignUp)
    sign_up.update(update_params)

    if sign_up.errors.present?
      render :error
    else
      render :done
    end
  end

  private

  def create_params
    {
      first_name: params.require(:last_name),
      last_name: params.require(:last_name),
      email: params.require(:email),
      password: params.require(:password),
      password_confirmation: params.require(:password_confirmation)
    }.each_value { |value| value.try(:strip!) }
  end

  def update_params
    {
      gender: params.require(:gender),
      university: params.require(:university),
      date_of_birth: date_of_birth,
    }.each_value { |value| value.try(:strip!) }
  end

  def date_of_birth
    year = params["date_of_birth(1i)"]
    month = params["date_of_birth(2i)"]
    day = params["date_of_birth(3i)"]

    return unless year.present? && month.present? && day.present?

    DateTime.new(year.to_i, month.to_i, day.to_i)
  end
end
