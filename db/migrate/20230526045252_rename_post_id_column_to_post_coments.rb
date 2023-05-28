class RenamePostIdColumnToPostComents < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_comments, :post_id, :post_blog_id
  end
end
