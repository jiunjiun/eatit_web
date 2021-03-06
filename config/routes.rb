EatitWeb::Application.routes.draw do
  root 'index#index'

  # get  'sign_in'                 => 'users#sign_in'
  get  'auth/:provider/callback' => 'users#auth_fb'
  get  'sign_failure'            => 'users#failure'
  # get  'sign_up'                 => 'users#sign_up'
  post 'sign_upping'             => 'users#sign_upping'
  get  'sign_out'                => 'users#sign_out'
  get  'user/account'            => 'users#account'


  resources :restaurants do
    collection do
      get 'search'
    end
  end

  resources :tasks do
    collection do
      get  'before/:offset' => 'tasks#before',  as: 'before',     offset: /[0-9]*/
      post 'fetch'          => 'tasks#fetch',   as: 'fetch'
      post 'finish/:id'     => 'tasks#finish',  as: 'finish'
      # get  'finished'       => 'tasks#finished', as: 'finished'
      post 'repeat/:id'     => 'tasks#repeat',  as: 'repeat'
    end
  end

  get '/:fb_username' => 'users#index', as: 'user_page'
  # namespace :dashboard do
  #   root "index#index"

  #   resources :restaurants do
  #     collection do
  #       get 'search'
  #     end
  #   end

  #   resources :tasks do
  #     collection do
  #       post 'finish/:id' => 'tasks#finish',  as: 'finish'
  #       get 'finishs'    => 'tasks#finishs', as: 'finishs'
  #     end
  #   end
  # end

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
