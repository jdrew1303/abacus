class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, null: false
      t.string :key, null: false
      t.text :domains

      t.belongs_to :admin

      t.timestamps null: false
    end

    add_index :apps, :key, unique: true
  end
end
