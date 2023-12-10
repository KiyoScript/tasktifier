class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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
end
