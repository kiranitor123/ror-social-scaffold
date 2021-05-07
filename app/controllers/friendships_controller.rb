class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @friendship = Friendship.new
  end

  def create
    host = current_user;
    friend = User.find(params[:friend_id])

    @friendship = Friendship.new(user_id: host.id, friend_id: friend.id)
    @friendship.save
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end
  end
end
