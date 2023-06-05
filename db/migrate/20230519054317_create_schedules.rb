class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|

      t.integer :user_id,     foreign_key: true
      t.string :title,        null: false
      t.text :memo,           null: false
      t.datetime :start_time, null: false

      t.timestamps
    end
  end
end
