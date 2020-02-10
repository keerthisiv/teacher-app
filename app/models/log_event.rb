class LogEvent < ApplicationRecord
  belongs_to :teacher

  enum event_type: {
    check_in: 'check in',
    check_out: 'check out',
  }

  validates_presence_of :event_time, :event_type
  validate :previous_event_conflict
  validate :first_event_is_check_in

  scope :order_by_latest, -> { order(event_time: :desc) }
  scope :for_teacher, ->(teacher) { where(teacher: teacher) }
  scope :events_during, -> (start_time, end_time) {
    where(event_time: start_time..end_time)
  }

  def previous_event_for_the_day
    start_at = event_time.beginning_of_day
    end_at = event_time - 1.second
    LogEvent.for_teacher(teacher)
      .events_during(start_at, end_at)
      .order_by_latest
      .first
  end

  private

  def previous_event_conflict
    if previous_event_for_the_day&.event_type == event_type
      errors.add(:event_type, "Please check the Event type: #{event_type} \
                 as the previous event was #{event_type} as well")
    end
  end

  def first_event_is_check_in
    if previous_event_for_the_day.nil? && event_type != 'check_in'
      day = event_time.strftime('%A, %b %d')
      errors.add(:event_type, "The first event for the day #{day} \
                 is not allowed to be check out")
    end
  end
end
