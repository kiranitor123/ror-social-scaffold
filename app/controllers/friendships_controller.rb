class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])

    if @friendship.save
      redirect_to users_path, notice: 'Friend invitation send'
    else
      redirect_to users_path, alert: 'Somthing go wrong :( '
    end
  end

  def update
    friend = User.find(params[:user_id])
    current_user.confirm_friend(friend)
    redirect_to user_path, notice: 'Friend invitation accepted'
  end

  def destroy
    friend = User.find_by(id: params[:user_id])
    current_user.reject_friend(friend)
    redirect_to user_path, notice: 'Oh, no reject invitation :('
  end
end
