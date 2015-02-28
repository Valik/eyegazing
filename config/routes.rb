Rails.application.routes.draw do

  root 'welcome#landing'
  get 'свидания-без-слов', to: 'welcome#index'
  get 'svidanija-bez-slov', to: 'welcome#index', as: :real_root
  get 'foto-i-video-otchjoty-i-otzyvy-s-proshedshih-svidanij-bez-slov', to: 'recalls#index', as: :recalls
  get 'фото-и-видео-отчёты-и-отзывы-с-прошедших-свиданий-без-слов', to: 'recalls#index'



 

  
  resources :pages, only: [:edit, :update]
  get 'pravila-svidanij-bez-slov', to: 'pages#rules', as: :rules
  get 'правила-свиданий-без-слов', to: 'pages#rules'
  
  get 'statji', to: 'pages#entities', as: :entities
  get 'статьи', to: 'pages#entities'
  
  
  get 'gde-poznakomitsya', to: 'pages#where_to_meet', as: :where_to_meet
  get 'где-познакомиться', to: 'pages#where_to_meet'
  
  get 'gde-naiti-devushku', to: 'pages#where_to_find_a_girl', as: :where_to_find_a_girl
  get 'где-найти-девушку', to: 'pages#where_to_find_a_girl'
  
  get 'gde-naiti-parnya', to: 'pages#where_to_find_a_man', as: :where_to_find_a_man
  get 'где-найти-парня', to: 'pages#where_to_find_a_man'
  
  get 'vecherinki-znakomstva', to: 'pages#looking_for_party', as: :looking_for_party
  get 'вечеринки-знакомства', to: 'pages#looking_for_party'
  
  get 'bistrie-svidaniya', to: 'pages#speed_dating', as: :speed_dating
  get 'быстрые-свидания', to: 'pages#speed_dating'
  
  
  
  get 'chto-tebja-ozhidaet', to: 'pages#structure', as: :structure
  get 'что-тебя-ожидает', to: 'pages#structure'
  
  get 'informacionnaja-stranica', to: 'pages#info_page', as: :info_page
  get 'информационная-страница', to: 'pages#info_page'

  get 'o-zritelnom-kontakte', to: 'articles#index', as: :articles
  get 'о-зрительном-контакте', to: 'articles#index'
  resources :articles, except: :index

  get 'albomy/foto', to: 'albums#photo', as: :albums_photo
  get 'альбомы/фото', to: 'albums#photo'
  get 'albomy/video', to: 'albums#video', as: :albums_video
  get 'альбомы/видео', to: 'albums#video'

  resources :parties, except: [:index, :show]
  get 'parties', to: 'parties#index'
  get 'vecherinki', to: 'parties#index', as: :all_parties
  get 'вечеринки', to: 'parties#index'

  resources :requests, only: [:create, :destroy, :show]
  get 'podat-zajavku/:id', to: 'requests#new', as: :new_request
  get 'подать-заявку/:id', to: 'requests#new'
  get 'podat-zajavku', to: 'requests#new'
  get 'подать-заявку', to: 'requests#new'


  resources :recalls, except: :index
  get 'recalls_moderation', to: 'recalls#moderation', as: :recalls_moderation

  resources :photos, only: [:create, :destroy, :show]
  resources :photos, only: :update, format: 'json', defaults: { photoable_type: 'Photo' }
  resources :videos, only: [:edit, :update, :create, :destroy]

  post 'welcome/subscribe', to: 'welcome#subscribe', as: :subscribe

  devise_for :admins
  get 'admin', to: redirect('admins/sign_in')
  get 'zajavki', to: 'requests#index', as: :all_requests
  get 'заявки', to: 'requests#index'

  get 'oplata', to: 'payments#index', as: :payments
  get 'оплата', to: 'payments#index'

  post 'payments/pay_with_yandex_money', to: 'payments#pay_with_yandex_money', as: :pay_with_yandex_money
  post 'payments/pay_with_card', to: 'payments#pay_with_card', as: :pay_with_card
  get 'payments/code', to: 'payments#code'
  get 'payments/success', to: 'payments#success', as: :succeed_payment
  get 'payments/fail', to: 'payments#fail', as: :failed_payment
  # resources :payments, only: :create, format: 'html'
  # get 'результат-оплаты', to: 'payments#pay_result', constraints: { protocol: 'https' }

end
