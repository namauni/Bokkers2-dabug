class CommentsController < ApplicationController
  def create
    book = Book.find(params[:post_image_id])
    comment = current_user.favorites.new(book_id: book.id)
    comment.post_image_id = post_image.id
    comment.save
    redirect_to post_image_path(post_image)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
