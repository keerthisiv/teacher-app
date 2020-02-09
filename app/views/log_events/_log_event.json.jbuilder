json.extract! log_event, :id, :teacher, :event_time, :description, :event_type, :created_at, :updated_at
json.url log_event_url(log_event, format: :json)
