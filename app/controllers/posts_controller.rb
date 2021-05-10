class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= current_user.posts.ordered_by_most_recent
    
    current_user.friends.each do |user|
      @timeline_posts += user.posts.ordered_by_most_recent
    end

    @timeline_posts.sort_by! { |post| -post.created_at.to_i }
    @timeline_posts.compact
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
