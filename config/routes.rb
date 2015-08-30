InstaTest::Application.routes.draw do
  get "activities/index"
  get "relationships/create"
  get "relationships/new"
  get "relationships/destroy"
  get "users/update"
  get "profile/index"
  get "search/index"
  get "upload/index"
  get "home/index"
  root 'home#index'
  mount PostgresqlLoStreamer::Engine => "/photo_data"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources 'users', :only => [:update]
  resources 'comments', :only => [:new, :create]
  resources 'photos', :only => [:new, :create, :update, :show]
  resources 'relationships', only: [:create, :destroy]

  post 'search' => 'search#search', :as => :search
  get 'profile_edit' => 'profile#edit', :as => :profile_edit
  get 'profile_show_more_photos' => 'profile#show_more_photos', :as => :profile_show_more_photos

  get 'comments_show_more' => 'comments#show_more_comments', :as => :comments_show_more

  get 'photos_show_more_feed' => 'photos#show_more_feed', :as => :photos_show_more_feed

  get 'photos_show_and_mark_read/:activity_id' => 'photos#show_and_mark_read', :as => :photos_show_and_mark_read

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
