class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.belongs_to :app

      t.string :key, null: false
      t.integer :weight, default: 0
      t.string :label

      t.timestamps null: false
    end

    add_index :event_types, [:app_id, :key], unique: true
  end
end
