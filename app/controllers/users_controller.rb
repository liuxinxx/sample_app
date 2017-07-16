class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])

  end
  def create
    @user = User.new(user_params)
    if @user.save
       log_in @user
      #闪现消息
      flash[:success] = "Welcome to the Sample App!"
      #重定向
      redirect_to @user
      # 处理注册成功的情况
    else
      render 'new'
    end
  end
  private
    def user_params
      params.require(:user).permit(:name,:email,:password,
                                    :password_confirmation)
    end
end
