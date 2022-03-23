class Book < ApplicationRecord

  # 追記 (Bookモデルに対し、UserモデルをN:1にアソシエート)
  belongs_to :user

  # バリデーション設定
  # 空でない
  validates :title, presence: true
  # 空でない,かつ最大200文字まで
  validates :body, presence: true
  validates :body, length: { maximum: 200 }

end
