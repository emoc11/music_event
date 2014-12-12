Rails.application.routes.draw do

  # Route par défaut => connexion avec lien vers inscription
  root :to => "sessions#new"

  # Routes pour affichage complet des parties, inscription et desinscription à l'une d'elle
  get 'parties/all'
  post 'parties/subscribe'
  post 'parties/unsubscribe'
  get 'users/edit'

  # Routes pour l'inscription, la connexion et deconnexion
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  # toutes les routes par défaut pour users, parties et sessions
  resources :users
  resources :parties
  resources :sessions
end
