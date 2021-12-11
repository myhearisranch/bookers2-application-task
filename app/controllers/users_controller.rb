class UsersController < ApplicationController

  def show
    @book_new = Book.new
    @user = User.find(params[:id])

    #bookだとエラーが出た
    @books = @user.books
  end

  def index
    @user = current_user
    @users = User.all
    @book_new = Book.new
  end


end
