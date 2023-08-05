class PostBlogsController < ApplicationController

  skip_before_action :authenticate_user!
  # 他のユーザーは編集、削除をできない
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  # ゲストユーザー管理
  before_action :ensure_general_user, only: [:create, :update, :show, :edit]

  def new
    if user_signed_in?
     @post_blog = PostBlog.new
    else
      redirect_to root_path
    end
  end

  def create
    @post_blog = PostBlog.new(post_blog_params)
    @post_blog.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:post_blog][:name].split(',')
    if  @post_blog.save
        @post_blog.save_tag(tag_list)
        if params[:post_blog][:status] == "published"
          flash[:notice] = "新規投稿しました"
        else
          flash[:notice] = "下書きに保存しました"
        end
        redirect_to post_blogs_path
    else
      render :new
    end
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
    @post_blogs = PostBlog.published.order(created_at: :desc).page(params[:page]).per(5)
    post_blog_ids = PostBlog.published.pluck(:id)
    @tag_list = Tag.where(id: PostTag.where(post_blog_id: post_blog_ids).pluck(:tag_id))
  end

  def confirm
    # 下書き一覧
    if user_signed_in?
      @post_blogs = current_user.post_blogs.draft.page(params[:page]).per(5)
    else
      redirect_to root_path
    end
  end

  def show
    @post_blog = PostBlog.find(params[:id])
    if @post_blog.status == "draft"
      redirect_to confirm_post_blogs_path
    else
      @post_comment = PostComment.new
      @post_tags = @post_blog.tags
    end
  end

  def edit
    @post_blog = PostBlog.find(params[:id])
    @tag_list = @post_blog.tags.pluck(:name).join(',')
  end

  def update
    @post_blog = PostBlog.find(params[:id])
    # @post_blog_img = PostBlog.find(params[:id])
    #入力されたタグを受け取る
    tag_list = params[:post_blog][:name].split(',')
    #もしpost_blogの情報が更新されたら
    if @post_blog.update(post_blog_params)
       #このpost_blog_idに紐づいたタグを@old_tagsに入れる
       @old_tags = PostTag.where(post_blog_id: @post_blog.id)
       @post_blog.save_tag(tag_list)
        #公開なら
        if params[:post_blog][:status] == "published"
          flash[:notice] = "投稿を更新しました"
          redirect_to post_blogs_path
        else
          flash[:notice] = "下書きを更新しました"
          if user_signed_in?
            redirect_to confirm_post_blogs_path
          else
            redirect_to post_blogs_path
          end
        end
    else
      # 入力した情報を引き継ぐ
      @post_blog = PostBlog.find(params[:id])
      @post_blog.update(post_blog_params_without_image)
      render :edit
    end
  end

  def destroy
    @post_blog = PostBlog.find(params[:id])
    # 配列を送るために空をつくる
    @post_blog.save_tag([])
    # モデルからのデータ取得
    if @post_blog.status == "published"
      flash[:notice] = "投稿を削除しました"
      @post_blog.destroy
      redirect_to post_blogs_path
    else
      flash[:notice] = "下書きを削除しました"
      @post_blog.destroy
      redirect_to confirm_post_blogs_path
    end
  end


  private

  def post_blog_params
    params.require(:post_blog).permit(:image, :title, :blog, :status, :user_id, :name)
  end

  def post_blog_params_without_image
    params.require(:post_blog).permit(:title, :blog, :status, :user_id, :name)
  end

  # ログインユーザーと管理者以外はトップページへ
  def is_matching_login_user
    if current_admin.present?
       current_admin.email == 'admin@example.com'
    elsif user_signed_in?
      post_blogs = current_user.post_blogs
      @post_blog = post_blogs.find_by(id: params[:id])
      redirect_to post_blogs_path unless @post_blog
    else
      redirect_to root_path
    end
  end

  #ゲストユーザー管理
  def ensure_general_user
    if current_user.present?
      if current_user.email == "guest@example.com"
        redirect_to root_path
      end
    end
  end

end
