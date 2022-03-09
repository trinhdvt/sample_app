class UsersController < ApplicationController
  include SessionsHelper

  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :logged_in_check, except: %i(new create show)
  before_action :is_admin?, only: :destroy

  def index
    @pagy, @users = pagy User.activated
  end

  def new
    @user = User.new
  end

  def show
    @pagy, @microposts = pagy @user.microposts.newest
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".new.success"
      redirect_to root_url
    else
      flash.now[:danger] = t ".new.failed"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update.success"
      redirect_to @user
    else
      flash.now[:danger] = t ".update.failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".destroy.success"
    else
      flash[:danger] = t ".destroy.failed"
    end
    redirect_to users_url
  end

  def following
    @title = t ".title"
    @pagy, @users = pagy @user.following
    render "show_follow"
  end

  def followers
    @title = t ".title"
    @pagy, @users = pagy @user.followers
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user&.activated?

    solve_not_found
  end

  def solve_not_found
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def correct_user
    return if current_user? params[:id]

    flash[:danger] = t ".unauthorized"
    redirect_to root_url
  end

  def is_admin?
    return if current_user.admin?

    flash[:danger] = t ".unauthorized"
    redirect_to root_url
  end
end
