class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  ## authenticatableは、(パスワード) 認証。resiterableは、(ユーザー) 登録。
  ## recoverableは、(パスワード) リセット。rememberableは、(ログイン情報) 保持。
  ## validatableは、(emailのフォーマットなど) 検証。
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 追記 (Userモデルに対し、Bookモデルを1:Nにアソシエート)
  has_many :books, dependent: :destroy
end
