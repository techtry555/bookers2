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
    # flashメッセージ は、ifでtrueを返すなら、flash[:notice] = "" & redirect_to
    ## flashメッセージ は、ifでfalseを返すなら、flash.new[:notice] = "" & render
    ## 今回は、flashメッセージのサクセスメッセージだけ (で、エラーメッセージの方は無い)。
    if @book.save
      ###flash[:notice] = "You have created book successfully."
      # ifでtrueの時、基本的に redirect_to。
      # 【book_path】は、books/:id、books#show。
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      # ifでfalseの時、基本的に render。
      # 【:index】は、/books、books#index。
      render :index
    end
  end


  def show
  end


  def edit
  end


  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
