class PostCommentsController < ApplicationController
  skip_before_action :authenticate_user!
  # before_action :is_matching_login_user!

  def create
    @post_blog = PostBlog.find(params[:post_blog_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_blog_id = @post_blog.id
    if @post_comment.save
       #redirect_to post_blog_path(post_blog.id)
       @post_blog = PostBlog.find(params[:post_blog_id])
       @post_comment = current_user.post_comments.new(post_comment_params)
    else
      #エラーメッセージ表示
      @error_comment = @post_comment
      @post_blog = PostBlog.find(params[:post_blog_id])
      @post_comment = PostComment.new
      @post_tags = @post_blog.tags
      render 'error'
    end
  end

  def destroy

    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    #redirect_to post_blog_path(params[:post_blog_id])
    @post_blog = PostBlog.find(params[:post_blog_id])
    #@post_comment = PostComment.new
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  # def is_matching_login_user
  #   if user_signed_in?
  #   elsif current_admin.present?
  #     current_admin.email == 'admin@example.com'
  #   else
  #     redirect_to root_path
  #   end
  # end

end