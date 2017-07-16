class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #登入用户重定向到用户资料页面
      log_in user
      redirect_to user
    else
      #创建一个错误消息
      flash.now[:danger] = 'Invalid email/password combination'
      # flash[:danger] = 'Invalid email/password combination' # 不完全正确
      render 'new'
    end

  end

  def destroy
    #退出当前用户
    log_out
    #重定向到首页
    redirect_to root_url
  end
end
