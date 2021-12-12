class BooksController < ApplicationController

    # https://qiita.com/nao0725/items/47606b8975603a12fd5eを参考に
    #↓他人の編集画面に遷移しないようにする記述

    before_action :correct_user, only: [:edit, :update]

def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    #フラッシュメッセージ実装
    if @book.save
        flash[:notice]="You have updated user successfully."
        redirect_to book_path(@book.id)
    else
        #↓2つの変数は、indexを表示する為の変数
        @books =Book.all
        @user = current_user
        render :index
    end
end

def show
    @book = Book.find(params[:id])

    #@bookだと↑と混同してしまう
    @book_new = Book.new
end

def index
    @books = Book.all

    #index.html.erb undifined method errors for nill
    #を解決する為に記述
    #/bookでindex.html.erbを表示する際に必要

    @book = Book.new

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
    @book = Book.find(params[:id])
    @book.user_id = current_user.id

    #フラッシュメッセージ実装
    if @book.update(book_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to book_path(book.id)
    else
        render :edit
    end
end

private

    def book_params
        params.require(:book).permit(:title, :body)
    end

    # https://qiita.com/nao0725/items/47606b8975603a12fd5eを参考に
    #↓他人の編集画面に遷移しないようにする記述

    def correct_user
        @book = Book.find(params[:id])
        @user = @book.user
        redirect_to(books_path) unless @user == current_user
    end
end
