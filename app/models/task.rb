class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  validates :title, presence: true

  enum repeat: {
    once: 0,
    daily: 1,
    mon_fri: 2
  }, _prefix: true

  enum mark_as_done: {
    false: 0,
    true: 1
  }, _prefix: true


  store :notify, accessors: [ :start_time, :reminder_at ], coder: JSON
end
