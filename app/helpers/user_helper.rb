module UserHelper
  def owner_or_friend?(user)
    current_user.id == user.id || current_user.friend?(user)
  end

  def owner?(user)
    current_user.id == user.id
  end

  def get_is_my_friend_or_request(user)
    return if owner?(user)

    return render html: '<button type="button" class="bttn-friend"><i class="fas fa-heart"></i><span> Accepted</span></button>'.html_safe if current_user.friend?(user)

    if current_user.pending_friendship?(user)
      render html: '<button type="button" class="bttn-friend"><i class="fas fa-heartbeat"></i><span> Pending</span></button>'.html_safe
    else
      link_to('Add Friend?', user_friendships_path(user_id: user.id), method: :post, class: '')
    end
  end

  def accept_friendship(friendship)
    actual_user = User.find_by(id: params[:id])
    return unless current_user == actual_user

    link_to('Accept', user_friendship_path(friendship.user, friendship.id), method: :put, class: 'tag-color')
  end

  def reject_friendship(friendship)
    actual_user = User.find_by(id: params[:id])
    return unless current_user == actual_user

    link_to('Reject', user_friendship_path(friendship.user, friendship.id), method: :delete, class: 'tag-color')
  end
end
