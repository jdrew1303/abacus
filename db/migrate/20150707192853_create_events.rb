class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :event_type, null: false
      t.belongs_to :medium, null: false
      t.string :user_id
      t.integer :timestamp, null: false
      t.integer :weight
      t.text :optional_data

      t.timestamps null: false
    end

    add_index :events, [:event_type_id, :medium_id, :user_id]
  end
end
