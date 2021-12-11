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

  def edit
    @user = User.find(params[:id])

    #↓の2つ書いたらparamsparam is missing or the value is empty: userというエラーが出た
    #user.update(user_params)
   #redirect_to user_path(user.id)
  end

  def update
      user = User.find(params[:id])

       #https://pikawaka.com/rails/flashより、フラッシュメッセージを実装
       #↓フラッシュメッセージを実装する方法

      if user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(user.id)
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
