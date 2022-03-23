class UsersController < ApplicationController

  # 【before_action】は、各アクションが実行される前に呼ばれる。
  # ログイン済みのユーザのみアクセスできる、の意。2つのアクションのみ適応。deviseで用意。
  before_action :authenticate_user!, only: [:edit, :update]
  # 他人が本の編集ページに遷移できなくする設定。【correct_user】は、ストロングパラメータ後に記述。
  before_action :ensure_correct_user, only: [:edit, :update]


  def index
    # Userの空のモデルの管理する全レコードを取得し、それをviewへ渡す@usersへ格納。(複数よりs付けた)。
    @users = User.all
    # Bookの空のモデルを作り、それをviewへ渡す@bookに格納。
    @book = Book.new
  end

  def show
    # urlのidに対応する、Userモデルが管理するDBの情報を1件取得。
    @user = User.find(params[:id])
    @book_new = Book.new
    # Userモデルに紐づいた、Bookモデルのカラム(title,body,user_id)を@booksへ格納。
    # user.rbの 【has_many :books,~】より。
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # urlに紐つくレコードを1件取得し(email/password/name/introduction)、@userへ格納。
    @user = User.find(params[:id])
    # 入力した値で更新できたら
    if @user.update(user_params)
      # flashの表示。【flash[:キー名]="表示したいメッセージ"】。キー名は自由。
      flash[:notice] = "You have updated user successfully."
      # user_path => users#show。(@user.id)忘れずに。
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  # ストロングパラメータ
  def user_params
    # profile_imageの追加
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # ログインユーザの確認
  def ensure_correct_user
    @user = User.find(params[:id])
    # ログインユーザのidがユーザのidでない場合
    unless @user.id == current_user.id
      # user_path => users#show
      redirect_to user_path(current_user)
    end
  end
end
