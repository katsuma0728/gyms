class RenamePostIdColumnToLikes < ActiveRecord::Migration[6.1]
  def change
    rename_column :likes, :post_id, :post_blog_id
  end
end
