class Book < ApplicationRecord

  # 追記 (Bookモデルに対し、UserモデルをN:1にアソシエート)
  belongs_to :user

  # Bookモデルで画像を使う宣言
  has_one_attached :image

  # バリデーション設定
  # 空でない
  validates :title, presence: true
  # 空でない,かつ最大200文字まで
  validates :body, presence: true
  validates :body, length: { maximum: 200 }

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
