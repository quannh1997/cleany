Rails.application.routes.draw do
  
  get 'partner/login' => 'partner_sessions#new', as: 'partner_login'
  post 'partner/login' => 'partner_sessions#create'
  delete 'partner/signout' => 'partner_sessions#destroy'
  get 'partner/signup' => 'partners#new'
  post 'partner/signup' => 'partners#create'
  
  resources :partners, except: [:new]

  get 'partner/working' => 'partners#showWorking', as: 'partner_working'
  get 'user/booking' => 'users#showBooking', as: 'user_booking'

  root "homes#index"

  namespace :admin do
    # get 'sessions/new'
    # get 'sessions/create'
    # get 'sessions/destroy'
    resources :sessions, only: [:new, :create, :destroy]
    # get 'signup', to: 'users#new', as: 'signup'
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
    get '', to: 'admins#dashboard', as: 'dashboard'
    get 'dashboard', to: 'admins#dashboard'
    get 'users_list', to: 'admins#show_users', as: 'users_list'
    get 'resetpass', to: 'admins#resetpass', as: 'resetpass'
    post 'reset', to: 'admins#send_reset_mail', as: 'send_reset_mail'
    get 'newpassword' => 'reset_password#edit', as: 'new_password'
    post 'user_destroy' => 'admins#destroy_user', as: 'user_destroy'
    get 'partners_list', to: 'admins#show_partners', as: 'partners_list'
    post 'partner_destroy' => 'admins#destroy_partner', as: 'partner_destroy'
    post 'salary_edit' => 'admins#edit_salary', as: 'salary_edit'
  end

  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  get 'get_district' => 'homes#get_district'
  get 'partner_detail/:id' => 'homes#partner_detail'
  get 'staff_search' => 'partners#search', as: 'staff_search'
  post 'booking' => 'books#handleBook'

  post 'deleteBooking' => 'books#deleteBooking'
  post 'acceptBooking' => 'books#acceptBooking'
  
  resources :users, except: [:new]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :partner_password_resets, only: [:new, :create, :edit, :update]
  resources :partner_change_password

  get '/partner_detail/:id', to: 'homes#partner_detail', as: 'partner_detail'
  post 'createComment' => 'users#createComment', as: 'create_comment'
  post 'deleteComment' => 'homes#delete_comment'
  
end
