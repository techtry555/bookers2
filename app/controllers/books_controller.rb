class BooksController < ApplicationController

  def index
    # Bookモデルの管理する全レコードを取得し、それをviewへ渡す@booksへ格納。(複数よりs付けた)。
    @books = Book.all
    # Bookモデルの空のモデルを作り、それをviewへ渡す@bookに格納。
    @book = Book.new
  end


  # 保存画面のアクション定義
  def create
    # 空のモデルを作成し、入力データを入れ、@bookに格納。
    @book = Book.new(book_params)
    # 見落としやすい点
    # アソシエーションの部分。現在ログイン中のuser_idを、Bookモデムのuser_idにする。
    @book.user_id = current_user.id
    # flashメッセージ は、ifでtrueを返すなら、flash[:notice] = "メッセージ" & redirect_to
    # flashメッセージ は、ifでfalseを返すなら、flash.new[:notice] = "メッセージ" & render
    if @book.save
      flash[:notice] = "You have created book successfully."
      # 【book_path】は、 books/:id => books#show。
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      # 【:index】は、/books => books#index。
      render :index
    end
  end

  def show
    # viewでの表示は1冊なので、単数表示@book。
    # urlのidに対応したDBの情報を引数として渡し、1件取得する。
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    # urlに紐つくレコードを1件取得し、@bookへ格納。
    @book = Book.find(params[:id])
    # 見落としやすい点。Bookモデルのカラムは(title/body/user_id)。
    # 取得したカラム(use_id)を現在ログイン中のuser_idに更新。
    @book.user_id = current_user.id
    # 入力した値で更新できたら
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      # book_path => books#show
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    # books_path => books#index
    redirect_to books_path
  end


  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
