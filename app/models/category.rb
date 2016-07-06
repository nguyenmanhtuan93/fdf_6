class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy

  class << self
    def options_for_select
      order("LOWER(name)").map {|category| [category.name, category.id]}
    end
  end
end
