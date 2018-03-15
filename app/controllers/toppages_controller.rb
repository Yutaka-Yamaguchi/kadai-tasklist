class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @tweettask = current_user.tweettasks.build  # form_for 用
      @tweettasks = current_user.tweettasks.order('created_at DESC').page(params[:page])
    end
  end
end