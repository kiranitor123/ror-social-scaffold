module UserHelper
  def owner(user)
    current_user.id == user.id
  end

  def get_is_my_friend_or_request(user)
    return if owner(user)

    return render html: '<i class="fas fa-heart"></i>'.html_safe if current_user.friend?(user)

    if current_user.pending_friends.include?(user) || current_user.friend_requests.include?(user)
      render html: '<i class="fas fa-heartbeat"></i> <span>Pending</span>'.html_safe
    else
      link_to('Add Friend?', user_friendships_path(user_id: user.id), method: :post, class: '')
    end
  end

  def accept_friendship(friendship)
    actual_user = User.find_by(id: params[:id])
    return unless current_user == actual_user

    link_to('Accept?', user_friendship_path(user_id: friendship.id), method: :put, class: '')
  end

  def reject_friendship(friendship)
    actual_user = User.find_by(id: params[:id])
    return unless current_user == actual_user

    link_to('Reject?', user_friendship_path(user_id: friendship.id), method: :delete, class: '')
  end
end
