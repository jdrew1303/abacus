class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :event_type
      t.belongs_to :medium
      t.integer :user_id
      t.integer :weight
      t.integer :timestamp
      t.text :optional_data

      t.timestamps null: false
    end

    add_index :events, [:event_type_id, :medium_id, :user_id]
  end
end
