class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  enum repeat: [ :false, :true ], _prefix: true
  enum mark_as_done: [ :false, :true ], _prefix: true

  store :notify, accessors: [ :time_reminder, :reminder_at ], coder: JSON
end
