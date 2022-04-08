class UsersController < ApplicationController

   # 編集画面表示、修正内容の更新アクション実行時はログインしているユーザーの場合のみ実行可とする。
   #https://tamata78.hatenablog.com/entry/2015/12/16/205728より、
   #↓他人のユーザ情報編集画面に遷移できない記述

   before_action :correct_user,   only: [:edit, :update]

  def show
    @book_new = Book.new
    @user = User.find(params[:id])

    #bookだとエラーが出た
    @books = @user.books

    #DM機能

    #↓の2行で現在、ログインしているユーザーと「チャットへ」を
    #押されたユーザーの両方をEntryテーブルに記録する。

    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)

    #現在、ログインしているユーザーではない
    unless @user.id == current_user.id

     #roomsが作成されている場合とされていない場合で
     #条件分岐させる

     #roomsが既に作成されている時

     #@currentUserEntryをeachを1つ1つ取り出す
      @currentUserEntry.each do |cu|

        #@userEntryをeachで1つ1つ取り出す
        @userEntry.each do |u|

          #room_idが共通しているユーザー同士に対して@roomId = cu.room_id
          #という変数を指定する
          #これにより,既に作成されているroom_idを特定できる
          if cu.room_id == u.room_id then

            #これがfalseの時、つまりRoomを作成する時の
            #条件を記述をするためにに記述した。
            @isRoom = true

            @roomId = cu.room_id
          end
        end
      end

    #roomsが作成されている場合とされていない場合で
    #条件分岐させる

    #roomsが作成されていない時、roomsを作成する
    unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end

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
      @user = User.find(params[:id])

       #https://pikawaka.com/rails/flashより、フラッシュメッセージを実装
       #↓フラッシュメッセージを実装する方法

      if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
      else
        render :edit
      end
  end

  private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    #https://tamata78.hatenablog.com/entry/2015/12/16/205728より、
    #他人のユーザ情報編集画面に遷移できない記述

    def correct_user
      @user = User.find(params[:id])
      if current_user != @user
       redirect_to user_path(current_user.id)
      end
    end
end
