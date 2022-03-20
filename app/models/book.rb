class Book < ApplicationRecord

  # 追記 (Bookモデルに対し、UserモデルをN:1にアソシエート)
  belongs_to :user

  # Bookモデルで画像を使う宣言
  has_one_attached :image

  # 画像が表示されない場合にエラーが出るため、その対応策。get_imageメソッドの作成。
  # この場所(=モデル)に記述することで、このメソッドを(カラムのように)いつでも呼び出せる。
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
end
