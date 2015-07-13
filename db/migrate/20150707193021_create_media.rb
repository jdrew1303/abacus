class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.belongs_to :app

      t.integer :media_id, null: false
      t.string :url
      t.integer :duration

      t.timestamps null: false
    end

    add_index :media, [:app_id, :media_id], unique: true
  end
end
