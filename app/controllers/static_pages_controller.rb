class StaticPagesController < ApplicationController
  include SessionsHelper

  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy(current_user.feed.newest)
  end

  def help; end

  def about; end

  def contact; end
end
