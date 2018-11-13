class PostsController < ApplicationController
  
  before_action :authenticate_user
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end
  
  def new 
    @post = Post.new
  end
  
  def create
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
    )
    respond_to do |format|
      if @post.save
        format.html
        format.js
      else
        format.js {render :new}
        #render("/posts/new")
      end
    end
  end
  
  def create_post
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
    )
    if @post.save
      redirect_to("/posts/index")
      flash[:notice] = "新しい投稿が完了しました！"
    else
      render("/posts/new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    respond_to do |format|
      if @post.destroy
        format.html
        format.js
      else
        format.js {render :index}
        #redirect_to("/posts/index")
      end
    end
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    respond_to do |format|
      if @post.save
        format.html
        format.js
      else
        format.js {render :new}
        #render("/posts/edit")
      end
    end
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @current_user.id == 1 || @current_user.id == 3
    elsif @post.user_id != @current_user.id
      flash[:notice] = "他ユーザーの投稿を編集する権限がありません"
      redirect_to("/posts/index")
    end
  end
end