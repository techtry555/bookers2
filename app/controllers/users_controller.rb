class UsersController < ApplicationController
  def index
    # Userモデルの管理する全レコードを取得し、それをviewへ渡す@usersへ格納。(複数よりs付けた)。
    @users = User.all
    # Bookモデルの空のモデルを作り、それをviewへ渡す@bookに格納。
    @user = User.new
  end

  # ログイン後の画面。
  def show
    # urlのidに対応する、Userモデルが管理するDBの情報を1件取得。
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
end
