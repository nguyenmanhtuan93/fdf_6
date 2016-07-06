class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @comment = current_user.comments.build comment_params
    respond_to do |format|
      format.html {redirect_to @comment.product}
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to @comment.product}
      format.js
    end
  end

  def edit
  end

  def update
    @comment.update_attributes comment_params
    respond_to do |format|
      format.html {redirect_to @comment.product}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :product_id
  end
end
