module UserHelper
  def owner(user)
    current_user.id == user.id
  end
end
