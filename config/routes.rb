Rails.application.routes.draw do

  # Auth
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'


  root 'home#index'

  namespace :api do
    namespace :v1 do
      #resources :approval_nodes
      get 'approval_nodes/get_node', to: 'approval_nodes#get_node'
      get 'approval_nodes/get_invoice_node_info', to: 'approval_nodes#get_invoice_node_info'
      get 'approval_nodes/get_user_node_access_right', to: 'approval_nodes#get_user_node_access_right'
    end
  end
end
