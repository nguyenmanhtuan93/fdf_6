class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  %w(facebook twitter google_oauth2).each do |provider|
    define_method provider do
      @user = User.from_omniauth request.env["omniauth.auth"]
      if "twitter" == @user.provider
        nickname = env["omniauth.auth"].info.nickname.gsub(/[^0-9A-Za-z]/, "")
        @user.email = "#{nickname}@fdfmail.com"
        @user ||= User.find_by email: @user.email
        @user ||= User.create email: @user.email,
          password: @user.uid, password_confirmation: @user.uid
      end
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider.capitalize) if
          is_navigational_format?
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end

  def failure
    redirect_to root_path
  end
end
