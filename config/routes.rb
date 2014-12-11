Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_up: 'register', sign_in: 'login', sign_out: 'logout' }, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :decks do
    resources :cards
    get '/study', to: 'decks#study'
    patch '/update_comprehension', to: 'decks#update_comprehension'
  end
  
  root to: redirect('/decks')

end
