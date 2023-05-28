class ChangeOldTableNameToNewTableName < ActiveRecord::Migration[6.1]
  def change
    rename_table :posts, :post_blogs
    rename_table :comments, :post_comments
  end
end
