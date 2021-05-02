class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :invitations
  has_many :pending_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: 'friend_id'

  def friends
    friends_i_sent_invite = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invite = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_sent_invite + friends_i_got_invite
    User.where(id: ids)
  end

  def friends_with(user)
    Invitation.confirmed_record?(id, user.id)
  end

  def sent_invite(user)
    Invitation.create(friend_id: user.id)
  end
end
