Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/help',to:'static_pages#help'#,as:'helf' ->/helpでアクセスでき、helf_pathでパスを取得できる
  get '/about',to:'static_pages#about'
  get '/contact',to:'static_pages#contact'
  # GET /users/new が無効になるわけではない
  get '/signup',to:'users#new'
  post '/signup', to:'users#create'
  # get 'users/new',as:'signup' /users/new で users#new にアクセスできて、コード内ではsignup_pathでパスを扱える

  # SessionをRESTfulに扱う。リソースをDBではなくcookieで管理する。
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'

  #RESTfulなUsersリソースで必要となる全てのアクションが利用できるようになる
  resources :users
end
