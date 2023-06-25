class LikesController < ApplicationController
  def create
    @post_blog = PostBlog.find(params[:post_blog_id])
    like = current_user.likes.new(post_blog_id: @post_blog.id)
    like.save
    #redirect_to post_blog_path(post_blog)
  end

  def destroy
    @post_blog = PostBlog.find(params[:post_blog_id])
    like = current_user.likes.find_by(post_blog_id: @post_blog.id)
    like.destroy
    #redirect_to post_blog_path(post_blog)
  end

end
