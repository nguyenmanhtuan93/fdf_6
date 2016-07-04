class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_details, dependent: :destroy

  enum status: ["pending", "ordered", "delivering", "finished"]
  enum payment: ["direct", "coin"]
end
