class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :suggests, dependent: :destroy
end
