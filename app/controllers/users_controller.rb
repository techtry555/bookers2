class UsersController < ApplicationController
  def index
    # Userの空のモデルの管理する全レコードを取得し、それをviewへ渡す@usersへ格納。(複数よりs付けた)。
    @users = User.all
    # Bookの空のモデルを作り、それをviewへ渡す@bookに格納。
    @user = User.new
  end


  def show
    # urlのidに対応する、Userモデルが管理するDBの情報を1件取得。
    @user = User.find(params[:id])
    # Userモデルに紐づいたbookのカラムを追加。user.rbの 【has_many :books,~】より。
    @books = @user.books
  end


  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    # user_path => users#show。(@user.id)忘れずに。
    redirect_to user_path(@user.id)
  end

  private
  # ストロングパラメータ
  def user_params
    # profile_imageの追加
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
