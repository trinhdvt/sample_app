class RelationshipsController < ApplicationController
  include SessionsHelper

  before_action :logged_in_check
  before_action :find_user, only: :create
  before_action :find_followed_user, only: :destroy

  def create
    current_user.follow @user

    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.unfollow @user

    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:followed_id]
    user_not_found unless @user
  end

  def find_followed_user
    @user = Relationship.find_by(id: params[:id])&.followed
    user_not_found unless @user
  end

  def user_not_found
    flash[:danger] = t "users.not_found"
    redirect_to root_url
  end
end
