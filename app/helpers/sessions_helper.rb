module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def must_login
    if current_user.blank?
      redirect_to new_session_path
    end
  end

  def not_signup
    redirect_to tasks_path unless current_user.blank?
  end
end
