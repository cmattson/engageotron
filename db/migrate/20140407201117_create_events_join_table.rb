class CreateEventsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :contacts, :chapter_events do |t|
      # t.index [:contact_id, :chapter_event_id]
      t.index [:chapter_event_id, :contact_id], name: :events_contacts
    end
  end
end
