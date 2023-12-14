class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]


  has_one_attached :avatar, dependent: :destroy

  has_many :tasks, dependent: :destroy
  has_many :categories, dependent: :destroy
  enum role: {
    regular: 0,
    admin: 1
  }, _prefix: true

  enum gender: {
    male: 0,
    female: 1,
    prefer_not_to_say: 2
  }, _prefix: true


  def admin?
    role_admin?
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data.email).first
    unless user
      # Create a new user with the provided access token
      user = User.create(
        email: data.email,
        google_uid: access_token.uid,
        google_provider: access_token.provider,
        role: :regular,
        google_token: access_token.credentials.token,
        google_token_expire_at: access_token.credentials.expires_at,
        google_refresh_token: access_token.credentials.refresh_token,

        password: Devise.friendly_token[0, 20]
      )
      user.avatar.attach(io: URI.open(data.image), filename: 'google_avatar.jpg')
    end
    if user.google_uid.nil?
      user.avatar.attach(io: URI.open(data.image), filename: 'google_avatar.jpg')
      user.update(google_uid: access_token.uid, google_provider: access_token.provider, google_token: access_token.credentials.token)
    elsif access_token.credentials.expires_at.present? && Time.now >= access_token.credentials.expires_at
      new_token = refresh_token(access_token.credentials.refresh_token)
      user.update(google_token: new_token)
    end

    user
  end

  def self.refresh_token(refresh_token)
    client = OAuth2::Client.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], site: 'https://accounts.google.com')
    token = OAuth2::AccessToken.new(client, refresh_token)
    new_token = token.refresh!
    new_token.token
  end

  def self.ransackable_attributes(auth_object = nil)
    ["username", "email"]
  end
end
