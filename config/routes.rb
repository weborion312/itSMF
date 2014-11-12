AdvStackCmsRails::Application.routes.draw do
  devise_for :members, :controllers => { :sessions => "sessions", :registrations => 'registrations' }
  mount Ckeditor::Engine => '/ckeditor'

  
  namespace :admin do
    root 'portal#index'
    devise_for :users, :controllers => { :sessions => "admin/sessions", :registrations => "admin/users" }
    
    resources :users
    resources :articles
    resources :events
    resources :medias
    resources :locales
    resources :pages
    resources :designed_templates
    resources :settings
    resources :members
    
    post '/menus/update-menu' => 'menus#update_menu'
    resources :menus
    
    post '/page_components/new' => 'pages#create_page_component', as: :create_page_component
    delete '/page_components/:id/delete' => 'pages#destroy_page_component', as: :destroy_page_component
    
    post '/extra_texts/new' => 'pages#create_extra_text', as: :create_extra_text
    delete '/extra_texts/:id/delete' => 'pages#destroy_extra_text', as: :destroy_extra_text
  end

  get 'articles/:browser_url/:tag/search' => 'pages#show'
  get 'articles/:browser_url/:month/:year' => 'pages#show'
  get 'articles/:id/:browser_url' => 'pages#show_article'
  

  get 'events/:browser_url/:tag/search' => 'pages#show'
  get 'events/:id/:browser_url' => 'pages#show_event'
  

  get ':browser_url' => 'pages#show'

  
  root 'pages#index'

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
