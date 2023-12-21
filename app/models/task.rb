class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  validates :title, presence: true

  enum mark_as_done: {
    false: 0,
    true: 1
  }, _prefix: true


  enum status: {
    active: 0,
    archived: 1,
    completed: 2
  }

  store :notify, accessors: [ :start_time, :reminder_at ], coder: JSON
end
