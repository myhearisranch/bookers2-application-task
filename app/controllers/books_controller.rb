class BooksController < ApplicationController

def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
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

def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
end

private

def book_params
    params.require(:book).permit(:title, :body)
end
end
