class PostBlogsController < ApplicationController
  def new
    @post_blog = PostBlog.new
  end

  def create
    @post_blog = PostBlog.new(post_blog_params)
    @post_blog.user_id = current_user.id
    tag_list = params[:post_blog][:name].split(',') # 受け取った値を,で区切って配列にする
    @post_blog.save
    @post_blog.save_tag(tag_list)
    redirect_to post_blogs_path
  end

  def search
    @post_blogs = PostBlog.joins(:user).search(params[:keyword])#joinsでuserと繋げている。
    @keyword = params[:keyword]
    @tag_list = Tag.all
    render "index"
  end

  def search_tag
    @tag_list = Tag.all#検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])#検索されたタグに紐づく投稿を表示
    @post_blogs = @tag.post_blogs.page(params[:page]).per(5)
    render "index"
  end

  def index
    @post_blogs = PostBlog.published.page(params[:page]).per(5)
    @tag_list = Tag.all
  end

  def confirm
    @post_blogs = current_user.post_blogs.draft.page(params[:page]).per(5)
  end

  def show
    @post_blog = PostBlog.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post_blog.tags
  end

  def edit
    @post_blog = PostBlog.find(params[:id])
    @tag_list = @post_blog.tags.pluck(:name).join('#')
  end

  def update
    @post_blog = PostBlog.find(params[:id])
    tag_list = params[:post_blog][:name].split(',')
    @post_blog.update(post_blog_params)
    @post_blog.save_tag(tag_list)
    redirect_to post_blog_path(@post_blog.id)
  end

  def destroy
    post_blog = PostBlog.find(params[:id])
    post_blog.destroy
    redirect_to post_blogs_path
  end

  private

  def post_blog_params
    params.require(:post_blog).permit(:image, :title, :blog, :status, :user_id, :tag_id, :post_tag_id, :name)
  end

end
