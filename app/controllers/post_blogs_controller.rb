class PostBlogsController < ApplicationController

  # ゲストユーザー管理
  # before_action :ensure_general_user, only: [:create]

  def new
    @post_blog = PostBlog.new
  end

  def create
    @post_blog = PostBlog.new(post_blog_params)
    @post_blog.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:post_blog][:name].split(',')
    @post_blog.save
    @post_blog.save_tag(tag_list)
    redirect_to post_blogs_path
  end

  def search
    #joinsでuserと繋げている。
    @post_blogs = PostBlog.published.joins(:user).search(params[:keyword]).page(params[:page]).per(5)
    @keyword = params[:keyword]
    # 公開のみの投稿を検索
    post_blog_ids = PostBlog.published.pluck(:id)
    @tag_list = Tag.where(id: PostTag.where(post_blog_id: post_blog_ids).pluck(:tag_id))
    render "index"
  end

  def search_tag
    #検索されたタグを受け取る　# 公開のみの投稿を検索
    post_blog_ids = PostBlog.published.pluck(:id)
    @tag_list = Tag.where(id: PostTag.where(post_blog_id: post_blog_ids).pluck(:tag_id))
    #検索されたタグに紐づく投稿を表示
    @tag = Tag.find(params[:tag_id])
    @post_blogs = @tag.post_blogs.published.page(params[:page]).per(5)
    render "index"
  end

  def index
    # 公開のみの投稿
    @post_blogs = PostBlog.published.page(params[:page]).per(5)
    post_blog_ids = PostBlog.published.pluck(:id)
    @tag_list = Tag.where(id: PostTag.where(post_blog_id: post_blog_ids).pluck(:tag_id))
  end

  def confirm
    # 下書き一覧
    @post_blogs = current_user.post_blogs.draft.page(params[:page]).per(5)
  end

  def show
    @post_blog = PostBlog.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post_blog.tags
  end

  def edit
    @post_blog = PostBlog.find(params[:id])
    @tag_list = @post_blog.tags.pluck(:name).join(',')
  end

  def update
    @post_blog = PostBlog.find(params[:id])
    #入力されたタグを受け取る
    tag_list = params[:post_blog][:name].split(',')
    #もしpost_blogの情報が更新されたら
    if @post_blog.update(post_blog_params)
       #このpost_blog_idに紐づいたタグを@old_tagsに入れる
       @old_tags = PostTag.where(post_blog_id: @post_blog.id)
       @post_blog.save_tag(tag_list)
        #公開なら
        if params[:post_blog][:status] == "published"
          redirect_to post_blog_path(@post_blog.id)
        else
          redirect_to post_blogs_path
        end
    else
      render :edit
    end
  end

  def destroy
    @post_blog = PostBlog.find(params[:id])
    # 配列を送るために空をつくる
    @post_blog.save_tag([])
    @post_blog.destroy
    redirect_to post_blogs_path
  end

  # ゲストユーザー管理
  # def ensure_general_user
  #   if current_user.email == "guest@example.com"
  #     redirect_to root_path
  #   end
  # end

  private

  def post_blog_params
    params.require(:post_blog).permit(:image, :title, :blog, :status, :user_id, :tag_id, :post_tag_id, :name)
  end

end
