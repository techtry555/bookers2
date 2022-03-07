class UsersController < ApplicationController
  def index
  end
  
  # ログイン後の画面。
  def show
    @users = Users.all
    
    @user = User.find(para)
    
    # 画面左下の New book の部分。
    # Bookモデルの空のobjectを生成し、viewへ渡す@bookに格納。
    @book = Book.new
  end

  def edit
    
  end
end
