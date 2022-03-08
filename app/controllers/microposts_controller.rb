class MicropostsController < ApplicationController
  include SessionsHelper

  before_action :logged_in_check, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    if create_micropost
      flash[:success] = t ".success"
      redirect_to root_url
    else
      @pagy, @feed_items = pagy(current_user.feed.newest)
      flash.now[:danger] = t ".failed"
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end

    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def create_micropost
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach micropost_params[:image]
    @micropost.save
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t "users.unauthorized"
    redirect_to root_url
  end
end
