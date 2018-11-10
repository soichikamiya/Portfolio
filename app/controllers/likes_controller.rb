class LikesController < ApplicationController
  before_action :authenticate_user
    
  def create
    @posts = Post.all.order(created_at: :desc)
    @like = Like.new(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    respond_to do |format|
      if @like.save
        format.html
        format.js {redirect_to("/posts/index")}
      else
        format.js {render("/posts/index")}
      end
    end
    #redirect_to("/posts/index")
  end
  
  def destroy
    @posts = Post.all.order(created_at: :desc)
    @post = Post.find_by(id: params[:post_id])
    @post_user_id = @post.like.user_id
    @like = Like.find_by(
      user_id: @post_user_id,
      post_id: params[:post_id]
    )
    respond_to do |format|
      if @like.destroy
        format.html
        format.js {redirect_to("/posts/index")}
      else
        format.js {render("/posts/index")}
      end
    end
    #redirect_to("/posts/index")
  end
  
end