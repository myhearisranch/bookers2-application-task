class UsersController < ApplicationController

  def show
    @book = Book.new
    @user = User.find(params[:id])

    #bookだとエラーが出た
    @books = @user.books
  end

  def index

  end


end
