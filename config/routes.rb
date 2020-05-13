Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :author_list, only: :create
    end
  end
end
