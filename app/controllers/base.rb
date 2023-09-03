class Base < ApplicationController
  def set_current_user(user)
    hash = Digest::SHA1.hexdigest(user.id.to_s)
    user.update(current_session_id: hash)
    cookies[:session_id] = hash
  end

  def current_user
    @current_user ||= User.find_by(current_session_id: cookies[:session_id])
  end
end
