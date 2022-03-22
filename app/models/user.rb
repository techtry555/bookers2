class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  ## authenticatableは、(パスワード) 認証。resiterableは、(ユーザー) 登録。
  ## recoverableは、(パスワード) リセット。rememberableは、(ログイン情報) 保持。
  ## validatableは、(emailのフォーマットなど) 検証。
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Userモデルで画像を使う宣言。imageカラムが追加されたかの様に扱える。
  # ↓これ無いとbookのindexページの左上(user info)でエラー出る。
  has_one_attached :image

  ## bookのindexページ右側(Books)作成の際に追加。
  ## (profile_imageという名前で) ActiveStorageに、プロフィール画像を保存する設定。
  has_one_attached :profile_image

  # 追記 (Userモデルに対し、Bookモデルを1:Nにアソシエート)
  has_many :books, dependent: :destroy

  # バリデーション設定
  # 空でない,一意性,2~20文字まで
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
  validates :name, length: { maximum: 20 }

  # 空でない,かつ最大200文字まで
  validates :introduction, presence: true
  validates :introduction, length: { maximum: 50 }


  ## get_profile_imageメソッドを作成。
  ## actionとは少し異なり、特定の処理を名前で呼び出すことができる。
  ## Userモデルの中に記述することで、この処理(=メソッド)を呼び出せる。(カラムを扱うように。)
  def get_profile_image(width, height)

    # 画像が設定(添付)されない場合は、
    unless profile_image.attached?
      # app/assets/images に格納されている app/assets/images/no_image.jpg という画像を、
      ## デフォルト画像としてActiveStorageに格納する。
      file_path = Rails.root.join('app/assets/images/no_image.jpg')

      # 格納した画像 (file_path) を、添付(=表示)する。
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

    # 画像を、縦横共に100pxのサイズに変換する。
    # variant は、(形/異なる)(名/変形)の意味。
    ##profile_image.variant(resize_to_limit: [100, 100]).processed
    ## ↓に修正。利便性を高める為。100→変数に。
    # メソッドに対して引数を設定し、引数に設定した値に画像サイズを変換する。
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
