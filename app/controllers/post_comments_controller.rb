class PostCommentsController < ApplicationController

  def create
    post_blog = PostBlog.find(params[:post_blog_id])
    post_comment = current_user.post_comments.new(post_comment_params)
    post_comment.post_blog_id = post_blog.id
    if post_comment.save
       redirect_to post_blog_path(post_blog.id)
    else
      #エラーメッセージ表示
      @error_comment = post_comment
      @post_blog = PostBlog.find(params[:post_blog_id])
      @post_comment = PostComment.new
      @post_tags = @post_blog.tags
      render 'post_blogs/show'
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_blog_path(params[:post_blog_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end