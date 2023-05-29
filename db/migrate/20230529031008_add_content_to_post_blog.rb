class AddContentToPostBlog < ActiveRecord::Migration[6.1]
  def change
    add_column :post_blogs, :content, :string
  end
end
