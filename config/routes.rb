Rails.application.routes.draw do
	resources :users
	get 'sessions/new'

	resources :suppliers
	resources :receipts
	resources :customers
	resources :sessions
	resources :articles
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root "application#hello"
	
	get 'signup', to: 'users#new', as: 'signup'
	get 'login', to: 'sessions#new', as: 'login'
	get 'logout', to: 'sessions#destroy', as: 'logout'

end
