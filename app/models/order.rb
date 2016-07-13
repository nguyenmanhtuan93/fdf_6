class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_details, dependent: :destroy

  before_save :update_total_pay

  enum status: ["pending", "ordered", "delivering", "delivered"]
  enum payment: ["direct", "coin"]

  def total_pay
    order_details.collect {|i| i.valid? ? i.temporary_price * i.quantity : 0}.sum
  end

  private
  def update_total_pay
    self[:total_pay] = total_pay
  end
end
