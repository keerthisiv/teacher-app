module LogEventsHelper
  def event_types_to_select
    LogEvent.event_types.map { |key, value| [value, key] }
  end
end
