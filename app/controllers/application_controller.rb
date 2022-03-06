# deviseはcontrollerがないので、devise関係はここに記述。
class ApplicationController < ActionController::Base

  # devise利用の機能 (ユーザー登録、ログイン認証など) が使われる前に、
  # configure_permitted_parametersメソッドが実行される。
  before_action :configure_permitted_parameters, if: :devise_controller?

  # sing up後の遷移先の設定。deviseが用意しているメソッド。
  # 今回は、users#show へ。
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end


  # protected は、呼び出された他のcontrollerからも、参照できる。
  # ちなみに private は、記述したcontroller内のみでしか、参照できない。
  protected

  # strongパラメータと同様の機能。
  # configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを使うことで、
  # ユーザー登録 (sign_up) の際に、ユーザー名 (name) のデータ操作を許可する。
  # deviseの初期設定では、email.passwardを受け取れるようになっている。
  def configure_permitted_parameters
     ## 今回、仕様変更なのか？emailがデフォルトで設定されないエラーがででたので追加した。
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

end
