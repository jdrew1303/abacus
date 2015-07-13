class CreatePlaySegments < ActiveRecord::Migration
  def change
    create_table :play_segments do |t|
      t.integer :start_event_id, null: false
      t.integer :end_event_id, null: false

      t.timestamps null: false
    end

    add_index :play_segments, [:start_event_id, :end_event_id], unique: true
  end
end
