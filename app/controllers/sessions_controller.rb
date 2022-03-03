class SessionsController < ApplicationController
  include SessionsHelper

  def new; end

  def create
    email, password = params[:session].values_at(:email, :password)

    user = User.find_by email: email.downcase
    if user&.authenticate password
      login user
      redirect_to user
    else
      flash.now[:danger] = t ".create.failed"
      render :new
    end
  end

  def destroy
    log_out
    flash[:info] = t ".destroy"
    redirect_to root_url
  end
end
