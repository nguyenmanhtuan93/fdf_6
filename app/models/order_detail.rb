class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  before_save :summary
  after_destroy :update_order

  def temporary_price
    if persisted?
      self[:temporary_price]
    else
      product.price_tag
    end
  end

  private
  def summary
    self[:temporary_price] = temporary_price
    self[:total_price] = self[:temporary_price] * quantity
  end

  def update_order
    order[:total_pay] = order.total_pay
    order.save
  end
end
