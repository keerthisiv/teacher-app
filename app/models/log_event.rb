class LogEvent < ApplicationRecord
  belongs_to :teacher
  validates_presence_of :event_time
  enum event_type: {
    check_in: "check in",
    check_out: "check out",
  }
end
