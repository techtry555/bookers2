class Book < ApplicationRecord

  # 追記 (Bookモデルに対し、UserモデルをN:1にアソシエート)
  belongs_to :user

  # Bookモデルで画像を使う宣言
  has_one_attached :image
  
  d

end
