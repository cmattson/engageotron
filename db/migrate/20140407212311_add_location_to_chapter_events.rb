class AddLocationToChapterEvents < ActiveRecord::Migration
  def change
    add_column :chapter_events, :zip_code, :string
    add_column :chapter_events, :address, :string
    add_column :chapter_events, :city, :string
  end
end
