class CreateChapterEvents < ActiveRecord::Migration
  def change
    create_table :chapter_events do |t|
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
