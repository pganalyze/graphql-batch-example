class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.references :category, null: false
      t.timestamp :start_time, null: false
      t.timestamp :end_time, null: false

      t.timestamps
    end

    add_index :events, :name
  end
end
