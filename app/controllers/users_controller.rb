class UsersController < ApplicationController
  before_action :not_signup, only: [:new]
  before_action :must_login, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "ユーザー「#{@user.name}」を登録しました！"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    if current_user.id == User.find(params[:id])[:id] # 他ユーザーのマイページにアクセスした場合、タスク一覧に遷移
      @user = User.find(params[:id])
    else
      redirect_to tasks_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
