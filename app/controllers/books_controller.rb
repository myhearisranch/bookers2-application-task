class BooksController < ApplicationController

def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    #フラッシュメッセージ実装
    if @book.save
        flash[:notice]="You have updated user successfully."
        redirect_to book_path(@book.id)
    end
end

def show
    @book = Book.find(params[:id])

    #@bookだと↑と混同してしまう
    @book_new = Book.new
end

def index
    @books = Book.all
    @book_new = Book.new

    #ログインしている人の情報はcurrent_userで取得
    #current_user.idだとidのみを取得し、エラーになる
    @user = current_user
end

def edit
    @book = Book.find(params[:id])
end

def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to book_path
end

def update
    book = Book.find(params[:id])

    #フラッシュメッセージ実装
    if book.update(book_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to book_path(book.id)
    end
end

private

def book_params
    params.require(:book).permit(:title, :body)
end
end
