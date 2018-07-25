class PostsController < ApplicationController
  
  before_action :authenticate_user
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def new 
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
      )
    if @post.save
      flash[:notice] = "新しい投稿が完了しました！"
      redirect_to("/posts/index")
    else
      render("/posts/new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿が削除されました！"
    redirect_to("/posts/index")
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿が編集されました！"
      redirect_to("/posts/index")
    else
      render("/posts/edit")
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
