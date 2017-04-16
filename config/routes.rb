Rails.application.routes.draw do
  namespace 'api' do
    namespace :v1, defaults: { format: :json } do
      resources :users do
        resources :lists, except: :update
        collection do
          get 'find_user'
        end
      end

      resources :lists, only: [:update] do
        resources :items, only: [:create]
      end

      resources :items, only: [:destroy, :update]
    end
  end
end
