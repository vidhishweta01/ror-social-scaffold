module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def unfriend_post(friend)
    if current_user # rubocop:disable Style/GuardClause
      link_to 'Unfriend', invitations_destroy_path(invitation_id: Invitation.find_invitation(current_user.id, friend.id)) # rubocop:disable Layout/LineLength
    end
  end
end
