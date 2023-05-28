class PostBlogsController < ApplicationController
  def new
    @post_blog = PostBlog.new
  end

  def create
    @post_blog = PostBlog.new(post_blog_params)
    @post_blog.user_id = current_user.id
    @post_blog.save
    redirect_to post_blogs_path
  end

  def search
    @post_blogs = PostBlog.joins(:user).search(params[:keyword])#joinsでuserと繋げている。
    @keyword = params[:keyword]
    render "index"
  end

  def index
    @post_blogs = PostBlog.all.page(params[:page]).per(5)
  end

  def show
    @post_blog = PostBlog.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post_blog = PostBlog.find(params[:id])
  end

  def update
    @post_blog = PostBlog.find(params[:id])
    @post_blog.update(post_blog_params)
    redirect_to post_blog_path(@post_blog.id)
  end

  def destroy
    post_blog = PostBlog.find(params[:id])
    post_blog.destroy
    redirect_to post_blogs_path
  end

  private

  def post_blog_params
    params.require(:post_blog).permit(:image, :title, :blog, :status, :user_id)
  end

end
