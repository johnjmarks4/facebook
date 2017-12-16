Rails.application.routes.draw do

  get 'comments/new'

  post 'comments/new'

  get 'comments/create'

  post 'comments/create'

  #resources :posts

  get 'posts/comment' => 'posts#comment'

  post 'posts/comment' => "posts#comment"

  get 'posts/index', to: 'posts#index'

  get 'posts/new'

  post 'posts/new'

  get 'posts/create' => "posts#create"

  post 'posts/create' => "posts#create"

  get 'posts/show(:id)' => "posts#show"

  get 'posts/edit'

  get 'posts/show'

  post 'posts/show'

  get 'posts/update'

  get 'posts/like'

  post 'posts/like'

  get 'users/destroy'

  post 'users/destroy(:id)' => 'users#destroy'

  as :user do

    resources :users, :only => [:new, :create, :index]

    get 'users/sign_out' => 'users/sessions#destroy'

    get 'users/sign_in' => 'users/sessions#new'

    post 'users/index' => 'users#index'

    get 'users/sign_in' => 'users/sessions#create'

    post 'users/sign_in' => 'users/sessions#create'

    get 'users/sign_up' => 'users/registrations#new'

    post 'users/sign_up' => 'devise/registrations#new'

    get 'users/auth/:provider', to: 'users/sessions#create'

    get 'users/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'

    get 'auth/failure', to: redirect('/')

    get 'auth/facebook', to: 'users/omniauth_callbacks#passthru'

    get 'signout', to: 'users/sessions#destroy', as: 'signout'

    #delete 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session

    get 'users/list'

    get 'users/friends'

    get 'users/edit' => 'users/registrations#edit'

    root 'users/registrations#new'
  end

  get 'users/search'

  post 'users/search' => 'users#search'

  post 'users/:id' => 'users#show'

  get 'friendships/add'

  post 'friendships/add'

  get 'friendships/create'

  post 'friendships/create'

  get 'friendships/destroy'

  post 'friendships/destroy'

  get 'friendships/delete_request'

  post 'friendships/delete_request'

  #get 'https://www.facebook.com/login.php?skip_api_login=1&api_key=299910373849571&signed_next=1&next=https%3A%2F%2Fwww.facebook.com%2Fv2.11%2Fdialog%2Foauth%3Fredirect_uri%3Dhttp%253A%252F%252Flocalhost%253A3000%252Fusers%252Fauth%252Ffacebook%252Fcallback%26state%3Dbb0d01afbbe61d0623a638d1f5bc27cbb8235ec74edbd85c%26scope%3Demail%26response_type%3Dcode%26client_id%3D299910373849571%26ret%3Dlogin%26logger_id%3D732ec58c-14cb-498b-faa3-b9677cd0f443&cancel_url=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fauth%2Ffacebook%2Fcallback%3Ferror%3Daccess_denied%26error_code%3D200%26error_description%3DPermissions%2Berror%26error_reason%3Duser_denied%26state%3Dbb0d01afbbe61d0623a638d1f5bc27cbb8235ec74edbd85c%23_%3D_&display=page&locale=en_US&logger_id=732ec58c-14cb-498b-faa3-b9677cd0f443', as: facebook_path

  resources :users, :except => [:new, :create, :index]

  devise_for :models

  devise_for :users, :controllers => { registrations: "registrations", sessions: "sessions", omniauth_callbacks: "users/omniauth_callbacks" }
end