Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

#  get 'static_pages/help'
#  static_pages/helpでアクセスするのは回りくどいので、
#  /helpでstatic_pages#helpにアクセスしたい
  get '/help',to:'static_pages#help'#,as:'helf' ->/helpでアクセスでき、helf_pathでパスを取得できる
  get '/about',to:'static_pages#about'
  get '/contact',to:'static_pages#contact'
  get '/signup',to:'users#new'
# get 'users/new',as:'signup' /users/new で users#new にアクセスできて、コード内ではsignup_pathでパスを扱える

end
