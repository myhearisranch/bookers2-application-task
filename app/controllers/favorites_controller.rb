class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
  end


#ActionView::Template::Error (undefined method `id' for nil:NilClass):

#book = Book.find(params[:book_id])としていた。
# 定義した変数はjsファイルでも使われるので
# @book = Book.find(params[:book_id])

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
  end
end
