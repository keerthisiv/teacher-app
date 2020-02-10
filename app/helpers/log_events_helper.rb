module LogEventsHelper
  def event_types_to_select
    LogEvent.event_types.map { |key, value| [value, key] }
  end

  def format_event_time(time)
    time.to_s(:short)
  end
end
