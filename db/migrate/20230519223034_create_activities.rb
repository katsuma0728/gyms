class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      
      t.integer :user_id, foreign_key: true             #通知をもらうユーザー
      t.references :subject, polymorphic: true          #通知元のモデルの情報とID
      t.integer :action_type, null: false               #通知の種類
      t.boolean :cheacked, default: false, null: false  #読んだ？defaultで読んでないを入れます

      t.timestamps
    end
  end
end
