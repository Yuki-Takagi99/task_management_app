class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :new, :edit]

  def new
    @user = User.new
  end

  def index
    @users = User.all.includes(:tasks).order(created_at: :asc).page(params[:page]).per(10)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー「#{@user.name}」を登録しました。"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー「#{@user.name}」を更新しました。"
      redirect_to admin_users_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:info] = "ユーザー「#{@user.name}」を削除しました。"
      redirect_to admin_users_path
    else
      flash[:danger] = "管理者がいなくなるため、削除することができません。"
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    if current_user.admin?
      return true
    else
      flash[:danger] = 'あなたは管理者ではありません。'
      redirect_to root_path
    end
  end
end
