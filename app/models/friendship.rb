class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :invitation_yes, -> { joins(:users).where('status = ?', 'acepted') }
  scope :invitation_no, -> { joins(:users).where('status = ?', 'reject') }
  scope :invitation_pending, -> { joins(:users).where('status = ?', 'no response') }
end
