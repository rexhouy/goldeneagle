# -*- coding: utf-8 -*-
Rails.application.routes.draw do
  devise_for :users
        # The priority is based upon order of creation: first created -> highest priority.
        # See how all your routes lay out with "rake routes".

        # You can have the root of your site routed with "root"
        # root 'welcome#index'

        # Example of regular route:
        #   get 'products/:id' => 'catalog#view'

        ## 大屏分享
        get "shares" => "shares#index"
        get "shares/new" => "shares#new"
        get "shares/search" => "shares#search"
        get "shares/:id" => "shares#show", as: :share
        post "shares" => "shares#create"
        post "shares/like/:id" => "shares#like"

        ## 抢红包
        get "lottery" => "lottery#index"
        post "lottery/sign_in" => "lottery#sign_in"
        post "lottery/sms" => "lottery#send_sms"
        post "lottery" => "lottery#prize"

        # 上传图片
        post "images" => "images#create"

        namespace :admin do
                get "shares" => "shares#index", as: :shares
                get "shares/screen" => "shares#screen"
                get "shares/:id" => "shares#show", as: :share
                post "shares/pass/:id" => "shares#pass"
                post "shares/reject/:id" => "shares#reject"
                post "shares/duration/:id" => "shares#duration"

                resources :users
                resources :activities
                get "prizes" => "prizes#index"
                get "prizes/search" => "prizes#search"
                post "prizes/claim/:id" => "prizes#claim"
                root "home#index"
        end



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
