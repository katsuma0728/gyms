class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      
      t.integer :user_id, foreign_key: true
      t.references :subject, polymorphic: true
      t.integer :action_type, null: false
      t.boolean :cheacked, default: false, null: false

      t.timestamps
    end
  end
end
