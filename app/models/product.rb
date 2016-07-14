class Product < ActiveRecord::Base
  belongs_to :category

  has_many :order_details, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum classify: ["food", "drink"]

  validates :rating, format: {with: /\A\d+(?:.\d{0,2})?\z/},
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10}

  mount_uploader :image, ImageUploader

  filterrific available_filters: %w[
    with_name
    sorted_by
    with_category_id
    with_classify
    with_rating_from
    with_rating_to
    with_price_from
    with_price_to
  ]
  scope :with_name, -> with_name {where "name like ?", "%#{with_name}%"}
  scope :sorted_by, -> sorted_by{
    direction = (sorted_by =~ /desc$/) ? "desc" : "asc"
    case sorted_by.to_s
      when /^name_/
        order "LOWER(products.name) #{direction}"
      when /^rating_/
        order "products.rating #{direction}"
      else
        raise ArgumentError, "Invalid sort option: #{sort_option.inspect}"
    end
  }
  scope :with_classify, -> with_classify {where classify: Product.classifies[with_classify]}
  hash = {
    with_category_id: "category_id == ?",
    with_rating_from: "rating >= ?",
    with_rating_to: "rating <= ?",
    with_price_from: "price_tag >= ?",
    with_price_to: "price_tag <= ?"
  }
  hash.each do |key, value|
    self.class_eval("scope :#{key}, -> #{key} {where value, #{key}}")
  end

  class << self
    def options_for_sorted_by
      [
        ["Name (a-z)", "name_asc"],
        ["Rating", "rating_desc"]
      ]
    end
  end
end
