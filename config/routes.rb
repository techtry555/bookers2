Rails.application.routes.draw do

  ## この1文を一番上にしたことで、認証画面が表示できるようになった。
  ## 以前は、#show,#index のページが表示された。。
  ## つまり、上から順にコードは読み込まれている事が如実に分かった。
  # deviseを利用時に、URLとしてusersを含む。
  devise_for :users

  # ルートパス設定
  root to: 'homes#top'

  # aboutページの名前付きルーティング
  get 'homes/about' => 'homes#about', as: 'about'


  # resourcesでルート設定
  # (new,) index,show,edit は,HTTPリクエストがget。
  resources :users, only: [:index, :show, :edit]
  resources :books, only: [:index, :show, :edit, :create,:destroy]





end
