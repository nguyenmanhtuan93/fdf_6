module UsersHelper
  def gravatar_for user
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = Settings.img_size
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
