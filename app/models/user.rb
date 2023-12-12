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

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data.email).first
    unless user
      user = User.create(
          email: data.email,
          google_uid: access_token.uid,
          google_provider: access_token.provider,
          google_avatar: data.image,
          gender: 'prefer_not_to_say',
          password: Devise.friendly_token[0,20]
      )
    end
    if user.google_uid.nil?
      user.avatar.attach(io: URI.open(data.image), filename: 'google_avatar.jpg')
      user.update(google_uid: access_token.uid, google_provider: access_token.provider)
    end
    user
  end
end
