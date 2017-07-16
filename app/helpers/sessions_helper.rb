module SessionsHelper
  #登入指定用户
  def log_in(user)

    session[:user_id] = user.id
  end

end
