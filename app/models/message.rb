class Message < ApplicationRecord
  belongs_to :from_user, class_name: "User", foreign_key: "from_id"
  belongs_to :to_user, class_name: "User", foreign_key: "to_id"
  default_scope -> { order(created_at: :desc) }
  validates :from_id, presence: true
  validates :to_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
