module UserHelper
  def send_invites(user)
    if signed_in? && !Invitation.reacted?(current_user.id, user.id) && current_user != user # rubocop:disable Style/GuardClause
      link_to 'Send Invitation', invitations_create_path(ids: { id1: current_user.id, id2: user.id })
    end
  end

  def send_invite
    if signed_in? && !Invitation.reacted?(current_user.id, @user.id) && current_user != @user # rubocop:disable Style/GuardClause
      link_to 'Send Invitation', invitations_create_path(ids: { id1: current_user.id, id2: @user.id })
    end
  end

  def unfriend(friend)
    if @user == current_user # rubocop:disable Style/GuardClause
      link_to 'Unfriend', invitations_destroy_path(invitation_id: Invitation.find_invitation(@user.id, friend.id))
    end
  end

  def pending_invitation(invitation)
    User.find(invitation.user_id).name
  end

  def accept_invitation(invitation)
    link_to 'Accept', invitations_update_path(invitation_id: invitation.id)
  end

  def reject_invitation(invitation)
    link_to 'Reject', invitations_destroy_path(invitation_id: invitation.id)
  end

  def not_any_one_friends
    Post.all if current_user.friends.length.zero?
  end
end
