class Product < ActiveRecord::Base
  belongs_to :category

  has_many :order_details, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum classify: ["food", "drink"]

  validates :category_id, presence: true
  validates :rating, format: {with: /\A\d+(?:.\d{0,2})?\z/},
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10}

  mount_uploader :image, ImageUploader
end
