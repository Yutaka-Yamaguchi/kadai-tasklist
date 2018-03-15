class TweettasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]


  def create
    @tweettask = current_user.tweettasks.build(tweettask_params)
    if @tweettask.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tweettasks = current_user.tweettasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @tweettask.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def tweettask_params
    params.require(:tweettask).permit(:content,:status)
  end

  def correct_user
    @tweettask = current_user.tweettasks.find_by(id: params[:id])
    unless @tweettask
      redirect_to root_url
    end
  end
end