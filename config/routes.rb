Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :orders do
        resources :dhl_labels
    end
  end

  namespace :api do
    resources :orders do
      resources :shipments do
  	    member do
  	      post :generate_dhl_label, to: 'shipping_dhl_labels#generate_dhl_label'
  	    end
      end
    end
  end
end