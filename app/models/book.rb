class Book < ApplicationRecord

  # 追記 (Bookモデルに対し、UserモデルをN:1にアソシエート)
  belongs_to :user

end
