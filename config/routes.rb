DemoHealth::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :goals, only: [:create, :destroy]
  resources :weights, only: [:create, :destroy]
  resources :activities, only: [:create, :destroy]
  root 'static_pages#home'
  resources :calories
  #get "static_pages/calories"
  #get "goals/new"
  
  match '/activities/new', to: 'activities#new', via: 'get'
  match '/activities/index', to: 'activities#index', via: 'get'
  #match '/activities/new', to: 'activities#destroy', via: 'delete'
 
  match '/goals/new', to: 'goals#new', via: 'get'
  match '/goals/index', to: 'goals#index', via: 'get'
  match '/weights/new', to: 'weights#new', via: 'get'
  match '/weights/index', to: 'weights#index', via: 'get'
  match '/shared/weight_form1', to: 'shared#weight_form1', via: 'get'
  #match '/goals/new', to: 'goals#destroy', via: 'delete'
  match '/static_pages/calories',to:'static_pages#calories', via: 'get'
  match '/static_pages/graph',to:'static_pages#graph', via: 'get'
  match '/static_pages/temp',to:'static_pages#temp', via: 'get'

  match '/signup', to: 'users#new',           via: 'get'
  match '/signin', to: 'sessions#new',        via: 'get'
  match '/signout',to: 'sessions#destroy',    via: 'delete'
  match '/help',   to: 'static_pages#help',   via: 'get'
  match '/about_path',  to: 'static_pages#about',  via: 'get'
  match '/contact_path',  to: 'static_pages#contact',  via: 'get'
  match 'users/contact_path',  to: 'static_pages#contact',  via: 'get'
 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
