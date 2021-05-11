class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id]) rescue current_user
    @posts = @user.posts.ordered_by_most_recent
  end
end
