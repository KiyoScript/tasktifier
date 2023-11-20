class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  enum repeat: [ :true, :false ], _prefix: true

  store :notify, accessors: [ :time_reminder, :reminder_at ], coder: JSON
end
