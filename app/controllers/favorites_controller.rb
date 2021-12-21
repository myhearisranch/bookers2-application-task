class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save

    #↓画面の推移はせずそのままの画面にする
    #(つまり投稿一覧でいいねをしたら投稿一覧のままで、投稿詳細ページでいいねをしたら投稿詳細ページのままにする記述)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
