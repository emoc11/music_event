Rails.application.routes.draw do

  get 'modification/new'

  # Routes pour affichage complet des parties, inscription et desinscription à l'une d'elle
  get 'parties/all'
  post 'parties/suscribe'
  post 'parties/unsuscribe'

  # Routes pour l'inscription, la connexion et deconnexion
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  # Route par défaut => connexion avec lien vers inscription
  root :to => "sessions#new"

  # toutes les routes par défaut pour users, parties et sessions
  resources :users
  resources :parties
  resources :sessions
end
