class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :user_id, foreign_key: true
      t.string :title,    null: false
      t.text :blog,       null: false
      t.integer :status,  null: false, default: 0

      t.timestamps
    end
  end
end
