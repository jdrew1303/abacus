class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.belongs_to :app, null: false
      t.string :media_id, null: false
      t.integer :duration, null: false
      t.string :url

      t.timestamps null: false
    end

    add_index :media, [:app_id, :media_id], unique: true
  end
end
