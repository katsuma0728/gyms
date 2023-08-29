class PostCommentsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @post_blog = PostBlog.find(params[:post_blog_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_blog_id = @post_blog.id
    if @post_comment.save
      @post_blog = PostBlog.find(params[:post_blog_id])
      @post_comment = current_user.post_comments.new(post_comment_params)
    else
      # エラーメッセージ表示
      @error_comment = @post_comment
      @post_blog = PostBlog.find(params[:post_blog_id])
      @post_comment = PostComment.new
      @post_tags = @post_blog.tags
      render "error"
    end
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    @post_blog = PostBlog.find(params[:post_blog_id])
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:comment)
    end
end
