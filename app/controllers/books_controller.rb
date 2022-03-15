class BooksController < ApplicationController
  def index

    # Bookモデルの管理する全レコードを取得し、それをviewへ渡す@booksへ格納。(複数よりs付けた)。
    @books = Book.all

    # Bookモデルの空のモデルを作り、それをviewへ渡す@bookに格納。
    @book = Book.new
  end

  def show
  end

  def edit
  end
end
