json.array!(@chapter_events) do |chapter_event|
  json.extract! chapter_event, :id, :name, :date
  json.url chapter_event_url(chapter_event, format: :json)
end
