class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]


  has_one_attached :avatar, dependent: :destroy

  has_many :tasks, dependent: :destroy
  has_many :categories, dependent: :destroy

  has_many :google_connects

  enum role: {
    regular: 0,
    admin: 1
  }, _prefix: true

  enum gender: {
    male: 0,
    female: 1,
    prefer_not_to_say: 2
  }, _prefix: true

  def google
    connect = google_connects.find_by(active: true)

    return if connect.blank?

    response = connect.response["info"]
    { name: response["name"], email: response["email"], avatar: response["image"]}
  end


  def self.from_omniauth(access_token)
    data = access_token.info
    account = User.where(email: data['email']).first
    account ||= User.create(name: data['name'], email: data['email'], password: Devise.friendly_token[0, 20])
    account
  end
end
