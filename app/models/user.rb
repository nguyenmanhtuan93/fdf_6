class User < ActiveRecord::Base
  ratyrate_rater

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable,
    :validatable, :omniauthable
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggests, dependent: :destroy

  scope :normal_users, -> {where is_admin: false}

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
          user.name = data["name"] if user.name.blank?
        end
      end
    end
  end
end
