Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :orders do
        resources :dhl_labels
        member do
          post :show_shipment_state_dhl, to: 'orders#show_shipment_state_dhl'
        end
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