class Suggest < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true

  scope :order_by_time, -> {order created_at: :desc}
end
