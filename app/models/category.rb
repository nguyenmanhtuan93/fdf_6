class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :products,
    reject_if: lambda {|a| a[:name].blank?}, allow_destroy: true

  validates :name, presence: true

  class << self
    def options_for_select
      order("LOWER(name)").map {|category| [category.name, category.id]}
    end
  end
end
